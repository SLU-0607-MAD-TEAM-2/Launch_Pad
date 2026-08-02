import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../utils/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailDigests = false;

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: theme.colorScheme.surface,
          title: Text('Confirm Log Out', style: theme.textTheme.headlineMedium),
          content: Text(
            'Are you sure you want to log out of LaunchPad?',
            style: theme.textTheme.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.error,
                foregroundColor: AppColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<AuthProvider>().logout();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/');
                  }
                });
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Settings', style: theme.textTheme.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            _sectionHeader('ACCOUNT', theme),
            _buildItem(
              icon: Iconsax.user_edit,
              label: 'Edit Profile',
              onTap: () {
                final user = context.read<AuthProvider>().currentUser;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      initialName: user?.name ?? FirebaseAuth.instance.currentUser?.displayName ?? '',
                      initialLocation: user?.location ?? '',
                      initialBio: user?.bio ?? '',
                      initialRole: user?.role.name ?? '',
                      initialSkills: user?.skills.join(', ') ?? '',
                      initialGithub: user?.githubUrl ?? '',
                      initialLinkedin: user?.linkedInUrl ?? '',
                      onSave: (n, l, b, r, s, g, li) {},
                    ),
                  ),
                );
              },
              theme: theme,
            ),
            _buildItem(
              icon: Iconsax.message_edit,
              label: 'Send Feedback',
              onTap: () => Navigator.pushNamed(context, '/feedback'),
              theme: theme,
            ),

            const SizedBox(height: 8),
            _sectionHeader('APPEARANCE', theme),
            _buildSwitch(
              icon: isDark ? Iconsax.moon5 : Iconsax.sun_1,
              label: 'Dark Mode',
              value: isDark,
              onChanged: (_) => themeProvider.toggleTheme(),
              theme: theme,
            ),

            const SizedBox(height: 8),
            _sectionHeader('NOTIFICATIONS', theme),
            _buildSwitch(
              icon: Iconsax.notification,
              label: 'Push Notifications',
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
              theme: theme,
            ),
            _buildSwitch(
              icon: Iconsax.sms,
              label: 'Email Digests',
              value: _emailDigests,
              onChanged: (val) => setState(() => _emailDigests = val),
              theme: theme,
            ),

            const SizedBox(height: 8),
            _sectionHeader('SYSTEM', theme),
            _buildItem(
              icon: Iconsax.info_circle,
              label: 'About LaunchPad',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'LaunchPad',
                  applicationVersion: '2.0.0-MVP',
                  applicationIcon: const Icon(
                    Iconsax.flash_circle,
                    color: AppColor.primaryBlue,
                    size: 48,
                  ),
                  children: [
                    const Text(
                        'Connecting founders and product builders instantly.'),
                  ],
                );
              },
              theme: theme,
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
              ),
            ),
            const SizedBox(height: 8),

            // Log Out row
            _LogoutTile(onTap: () => _showLogoutDialog(context), theme: theme),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String label, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 1.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return _SettingsTile(
      icon: icon,
      label: label,
      onTap: onTap,
      trailing: Icon(
        Iconsax.arrow_right_3,
        size: 18,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      theme: theme,
    );
  }

  Widget _buildSwitch({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required ThemeData theme,
  }) {
    return _SettingsTile(
      icon: icon,
      label: label,
      onTap: null,
      trailing: Switch(
        value: value,
        activeTrackColor: AppColor.primaryBlue.withValues(alpha: 0.5),
        activeThumbColor: AppColor.primaryBlue,
        inactiveThumbColor: theme.colorScheme.onSurfaceVariant,
        inactiveTrackColor: theme.colorScheme.onSurface.withValues(alpha: 0.2),
        onChanged: onChanged,
      ),
      theme: theme,
    );
  }
}

// ─── Reusable tile ──────────────────────────────────────────────────────────

class _SettingsTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget trailing;
  final ThemeData theme;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.trailing,
    required this.theme,
  });

  @override
  State<_SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<_SettingsTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => setState(() => _pressed = true) : null,
      onTapUp: widget.onTap != null
          ? (_) {
              setState(() => _pressed = false);
              widget.onTap!();
            }
          : null,
      onTapCancel: widget.onTap != null
          ? () => setState(() => _pressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          color: _pressed
              ? AppColor.primaryBlue.withValues(alpha: 0.04)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppShapes.radiusXL),
          border: Border.all(
            color: _pressed
                ? AppColor.primaryBlue.withValues(alpha: 0.2)
                : theme.colorScheme.onSurface.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Icon badge
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColor.primaryBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  size: 20,
                  color: AppColor.primaryBlue,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(widget.label, style: theme.textTheme.titleSmall),
              ),
              widget.trailing,
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Log Out tile ────────────────────────────────────────────────────────────

class _LogoutTile extends StatefulWidget {
  final VoidCallback onTap;
  final ThemeData theme;
  const _LogoutTile({required this.onTap, required this.theme});

  @override
  State<_LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<_LogoutTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
          color: _pressed
              ? AppColor.error.withValues(alpha: 0.08)
              : AppColor.error.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(AppShapes.radiusXL),
          border: Border.all(
            color: AppColor.error.withValues(alpha: 0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColor.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.logout,
                  size: 20,
                  color: AppColor.error,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Log Out',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColor.error,
                  ),
                ),
              ),
              Icon(
                Iconsax.arrow_right_3,
                size: 18,
                color: AppColor.error.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
