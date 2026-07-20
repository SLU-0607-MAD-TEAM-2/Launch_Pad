import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColor.white,
          title: Text('Confirm Log Out', style: AppTypography.headlineMedium),
          content: Text(
            'Are you sure you want to log out of LaunchPad?',
            style: AppTypography.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: AppTypography.labelLarge
                    .copyWith(color: AppColor.mutedText),
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
    return Scaffold(
      backgroundColor: AppColor.screenBgLight,
      appBar: AppBar(
        backgroundColor: AppColor.screenBgLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Settings', style: AppTypography.titleMedium),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColor.borderHairline.withValues(alpha: 0.4),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            _sectionHeader('ACCOUNT'),
            _buildItem(
              icon: Iconsax.user_edit,
              label: 'Edit Profile',
              onTap: () => Navigator.pushNamed(context, '/edit_profile'),
            ),
            _buildItem(
              icon: Iconsax.message_edit,
              label: 'Send Feedback',
              onTap: () => Navigator.pushNamed(context, '/feedback'),
            ),

            const SizedBox(height: 8),
            _sectionHeader('NOTIFICATIONS'),
            _buildSwitch(
              icon: Iconsax.notification,
              label: 'Push Notifications',
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
            ),
            _buildSwitch(
              icon: Iconsax.sms,
              label: 'Email Digests',
              value: _emailDigests,
              onChanged: (val) => setState(() => _emailDigests = val),
            ),

            const SizedBox(height: 8),
            _sectionHeader('SYSTEM'),
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
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColor.borderHairline.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),

            // Log Out row
            _LogoutTile(onTap: () => _showLogoutDialog(context)),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
      child: Text(
        label,
        style: AppTypography.captionUppercase.copyWith(
          color: AppColor.mutedText,
          letterSpacing: 1.4,
        ),
      ),
    );
  }

  Widget _buildItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return _SettingsTile(
      icon: icon,
      label: label,
      onTap: onTap,
      trailing: const Icon(
        Iconsax.arrow_right_3,
        size: 18,
        color: AppColor.mutedText,
      ),
    );
  }

  Widget _buildSwitch({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _SettingsTile(
      icon: icon,
      label: label,
      onTap: null,
      trailing: Switch(
        value: value,
        activeTrackColor: AppColor.primaryBlue.withValues(alpha: 0.5),
        activeThumbColor: AppColor.primaryBlue,
        inactiveThumbColor: AppColor.mutedText,
        inactiveTrackColor: AppColor.borderHairline,
        onChanged: onChanged,
      ),
    );
  }
}

// ─── Reusable tile ──────────────────────────────────────────────────────────

class _SettingsTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget trailing;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.trailing,
  });

  @override
  State<_SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<_SettingsTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
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
              : AppColor.white,
          borderRadius: BorderRadius.circular(AppShapes.radiusXL),
          border: Border.all(
            color: _pressed
                ? AppColor.primaryBlue.withValues(alpha: 0.2)
                : AppColor.borderHairline.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.headingDark.withValues(alpha: 0.03),
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
                child: Text(widget.label, style: AppTypography.titleSmall),
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
  const _LogoutTile({required this.onTap});

  @override
  State<_LogoutTile> createState() => _LogoutTileState();
}

class _LogoutTileState extends State<_LogoutTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
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
                  style: AppTypography.titleSmall.copyWith(
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
