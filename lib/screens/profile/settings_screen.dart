import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/top_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppTopBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _settingTile(Icons.notifications_outlined, 'Notifications'),
            const Divider(height: 1, color: AppColor.stroke),
            _settingTile(Icons.lock_outlined, 'Privacy'),
            const Divider(height: 1, color: AppColor.stroke),
            _settingTile(Icons.help_outline, 'Help & Support'),
            const Divider(height: 1, color: AppColor.stroke),
            _settingTile(Icons.info_outline, 'About'),
            const Spacer(),
            PrimaryButton(
              text: 'Sign Out',
              onPressed: () {
                auth.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const _LogoutPlaceholder()),
                  (_) => false,
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _settingTile(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: AppColor.textSecondary),
      title: Text(label, style: AppTypography.bodyMedium),
      trailing: Icon(Icons.chevron_right, color: AppColor.textSecondary),
      onTap: () {},
    );
  }
}

class _LogoutPlaceholder extends StatelessWidget {
  const _LogoutPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Signed out')),
    );
  }
}
