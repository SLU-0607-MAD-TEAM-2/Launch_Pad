import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../models/user_profile.dart';
import '../utils/app_theme.dart';
import 'scale_tap.dart';

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
              color: AppColor.white,
              border: Border.all(
                color: AppColor.borderHairline.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryBlue.withValues(alpha: 0.08),
                  blurRadius: 32,
                  spreadRadius: 0,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: AppColor.headingDark.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppShapes.cardRadiusLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(cardWidth),
                  _buildBody(),
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
    final gradientColors = AppGradients.cardPresets[
        profile.id.hashCode.abs() % AppGradients.cardPresets.length];
    return Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientColors.first.withValues(alpha: 0.18),
            gradientColors.last.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          // Avatar with gradient ring
          Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: 27,
              backgroundColor: AppColor.white,
              child: Text(
                profile.name[0].toUpperCase(),
                style: AppTypography.headlineMedium.copyWith(
                  color: gradientColors.first,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name, style: AppTypography.titleMedium),
                if (profile.headline.isNotEmpty)
                  Text(profile.headline, style: AppTypography.bodySmall),
              ],
            ),
          ),
          // Open badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColor.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColor.success.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.verify5,
                  size: 11,
                  color: AppColor.success,
                ),
                const SizedBox(width: 3),
                Text(
                  'Open',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColor.success,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(Iconsax.briefcase, profile.role.name.capitalize()),
          if (profile.location.isNotEmpty)
            _infoRow(Iconsax.location, profile.location),
          const SizedBox(height: 14),
          if (profile.bio.isNotEmpty)
            Text(profile.bio, style: AppTypography.bodyMedium),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                profile.skills.take(5).map((s) => _SkillChip(s)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColor.mutedText),
            const SizedBox(width: 7),
            Text(text, style: AppTypography.bodySmall),
          ],
        ),
      );

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Pass
          ScaleTap(
            onTap: onSwipeLeft,
            scaleDown: 0.90,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.error.withValues(alpha: 0.07),
                border: Border.all(
                  color: AppColor.error.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Icon(Iconsax.close_circle, color: AppColor.error, size: 26),
            ),
          ),
          // Super Like (gradient centre button)
          ScaleTap(
            onTap: () {},
            scaleDown: 0.90,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColor.primaryBlue, AppColor.accentCyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primaryBlue.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(Iconsax.star5, color: AppColor.white, size: 22),
            ),
          ),
          // Connect
          ScaleTap(
            onTap: onSwipeRight,
            scaleDown: 0.90,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.success.withValues(alpha: 0.07),
                border: Border.all(
                  color: AppColor.success.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Icon(Iconsax.heart5, color: AppColor.success, size: 26),
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.pillRadius),
        color: AppColor.primaryBlue.withValues(alpha: 0.07),
        border: Border.all(
          color: AppColor.primaryBlue.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: AppColor.primaryBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

extension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
