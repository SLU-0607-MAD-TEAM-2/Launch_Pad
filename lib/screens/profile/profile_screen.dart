import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/top_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppTopBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: AppColor.primary.withValues(alpha: 0.15),
              child: Text(
                user.name[0].toUpperCase(),
                style: AppTypography.headlineLarge.copyWith(color: AppColor.primary),
              ),
            ),
            const SizedBox(height: 16),
            Text(user.name, style: AppTypography.titleLarge),
            if (user.headline != null) ...[
              const SizedBox(height: 4),
              Text(user.headline!, style: AppTypography.bodyMedium.copyWith(color: AppColor.textSecondary)),
            ],
            if (user.location != null) ...[
              const SizedBox(height: 4),
              Text(user.location!, style: AppTypography.bodySmall),
            ],
            const SizedBox(height: 24),
            _section('Bio', user.bio ?? 'No bio yet'),
            const SizedBox(height: 16),
            _section('Skills', user.skills.join(', ')),
            const SizedBox(height: 16),
            _section('Looking for team', user.isLookingForTeam ? 'Yes' : 'No'),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.radiusMD),
        color: AppColor.surface.withValues(alpha: 0.5),
        border: Border.all(color: AppColor.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.labelMedium),
          const SizedBox(height: 6),
          Text(content, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
