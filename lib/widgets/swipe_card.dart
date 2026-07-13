import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../theme/theme.dart';

class SwipeCard extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const SwipeCard({
    super.key,
    required this.profile,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth * 0.88;
        final cardHeight = constraints.maxHeight * 0.82;

        return Center(
          child: Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppShapes.cardRadiusLarge),
              gradient: AppGradients.surface,
              border: Border.all(color: AppColor.stroke, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withValues(alpha: 0.1),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppShapes.cardRadiusMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(cardWidth),
                  _buildBody(context),
                  const Spacer(),
                  _buildActions(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppGradients.cardPresets[
                profile.id.hashCode.abs() % AppGradients.cardPresets.length]
                .first
                .withValues(alpha: 0.2),
            Colors.transparent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColor.primary.withValues(alpha: 0.15),
            child: Text(
              profile.name[0].toUpperCase(),
              style: AppTypography.headlineMedium.copyWith(
                color: AppColor.primary,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name, style: AppTypography.titleMedium),
                if (profile.headline != null)
                  Text(profile.headline!, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Icons.work_outline, profile.role.name.capitalize()),
          if (profile.location != null)
            _infoRow(Icons.location_on_outlined, profile.location!),
          const SizedBox(height: 12),
          if (profile.bio != null)
            Text(profile.bio!, style: AppTypography.bodyMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: profile.skills.take(5).map((s) => _SkillChip(s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(icon, size: 14, color: AppColor.textSecondary),
        const SizedBox(width: 6),
        Text(text, style: AppTypography.bodySmall),
      ],
    ),
  );

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _actionButton(Icons.close_rounded, AppColor.error, onSwipeLeft),
          _actionButton(Icons.favorite_rounded, AppColor.success, onSwipeRight),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.pillRadius),
        color: AppColor.primary.withValues(alpha: 0.08),
        border: Border.all(color: AppColor.primary.withValues(alpha: 0.15)),
      ),
      child: Text(label, style: AppTypography.labelSmall),
    );
  }
}

extension on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
