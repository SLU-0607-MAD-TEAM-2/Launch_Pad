import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_theme.dart';

class SkillChip extends StatefulWidget {
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
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 70),
      reverseDuration: const Duration(milliseconds: 350),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Curves.easeInCirc,
        reverseCurve: const ElasticOutCurve(0.5),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null
          ? (_) {
              HapticFeedback.selectionClick();
              _ctrl.forward();
            }
          : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _ctrl.reverse();
              widget.onTap?.call();
            }
          : null,
      onTapCancel: widget.onTap != null ? () => _ctrl.reverse() : null,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppShapes.pillRadius),
            color: widget.selected
                ? AppColor.primaryBlue.withValues(alpha: 0.12)
                : AppColor.screenBgLight,
            border: Border.all(
              color: widget.selected
                  ? AppColor.primaryBlue.withValues(alpha: 0.5)
                  : AppColor.borderHairline,
              width: widget.selected ? 1.5 : 1,
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: AppTypography.labelMedium.copyWith(
              color: widget.selected ? AppColor.primaryBlue : AppColor.mutedText,
              fontWeight:
                  widget.selected ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.1,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
