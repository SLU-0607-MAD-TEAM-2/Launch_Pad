import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const SkillChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppShapes.pillRadius),
          color: selected
              ? AppColor.primary.withValues(alpha: 0.15)
              : AppColor.surface.withValues(alpha: 0.5),
          border: Border.all(
            color: selected ? AppColor.primary : AppColor.stroke,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: selected ? AppColor.primary : AppColor.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
