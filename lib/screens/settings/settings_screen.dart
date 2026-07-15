import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailDigests = false;

  void _showLogoutDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Confirm Log Out',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to log out of LaunchPad?',
            style: TextStyle(
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/'); // Return back to Splash/Login
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

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            // Account section header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'ACCOUNT',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            _buildSettingsItem(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              theme: theme,
              onTap: () {
                Navigator.pushNamed(context, "/edit_profile");
              },
            ),
            const SizedBox(height: 16),
            // Notifications section header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'NOTIFICATIONS',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            _buildSwitchItem(
              icon: Icons.notifications_none,
              title: 'Push Notifications',
              value: _pushNotifications,
              theme: theme,
              onChanged: (val) {
                setState(() {
                  _pushNotifications = val;
                });
              },
            ),
            _buildSwitchItem(
              icon: Icons.mail_outline,
              title: 'Email Digests',
              value: _emailDigests,
              theme: theme,
              onChanged: (val) {
                setState(() {
                  _emailDigests = val;
                });
              },
            ),
            const SizedBox(height: 16),
            // About section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                'SYSTEM',
                style: TextStyle(
                  fontFamily: 'Geist',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            _buildSettingsItem(
              icon: Icons.info_outline,
              title: 'About LaunchPad',
              theme: theme,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'LaunchPad',
                  applicationVersion: '2.0.0-MVP',
                  applicationIcon: Image.asset(
                    'assets/images/logo.png',
                    width: 48,
                    height: 48,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.rocket_launch,
                      color: Color(0xFF0052FF),
                      size: 48,
                    ),
                  ),
                  children: [
                    const Text('Connecting founders and product builders instantly.'),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              leading: Icon(
                Icons.logout,
                color: theme.colorScheme.error,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: theme.colorScheme.error,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: theme.colorScheme.error.withValues(alpha: 0.5),
              ),
              onTap: () => _showLogoutDialog(context, theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF0052FF), // Electric Blue
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF0F172A),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFF94A3B8),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required bool value,
    required ThemeData theme,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF0052FF),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF0F172A),
        ),
      ),
      trailing: Switch(
        value: value,
        activeTrackColor: const Color(0xFF0052FF).withValues(alpha: 0.5),
        activeThumbColor: const Color(0xFF0052FF),
        onChanged: onChanged,
      ),
    );
  }
}
