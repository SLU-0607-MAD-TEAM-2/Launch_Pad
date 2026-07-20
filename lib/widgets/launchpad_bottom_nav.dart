import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';
import '../utils/app_theme.dart';

class LaunchPadBottomNav extends StatelessWidget {
  const LaunchPadBottomNav({super.key});

  static const _items = [
    _NavItem(
      label: 'Discovery',
      activeIcon: Iconsax.discover5,    // filled/bold variant
      inactiveIcon: Iconsax.discover,
    ),
    _NavItem(
      label: 'Messages',
      activeIcon: Iconsax.message5,
      inactiveIcon: Iconsax.message,
    ),
    _NavItem(
      label: 'Profile',
      activeIcon: Iconsax.profile_circle5,
      inactiveIcon: Iconsax.profile_circle,
    ),
    _NavItem(
      label: 'Settings',
      activeIcon: Iconsax.setting_25,
      inactiveIcon: Iconsax.setting_2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    final currentIndex = nav.currentIndex;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColor.borderHairline.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.headingDark.withValues(alpha: 0.08),
            blurRadius: 32,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColor.primaryBlue.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_items.length, (index) {
          return Expanded(
            child: _NavTapTarget(
              isActive: currentIndex == index,
              item: _items[index],
              onTap: () {
                HapticFeedback.selectionClick();
                nav.setIndex(index);
              },
            ),
          );
        }),
      ),
    );
  }
}

class _NavTapTarget extends StatefulWidget {
  final bool isActive;
  final _NavItem item;
  final VoidCallback onTap;

  const _NavTapTarget({
    required this.isActive,
    required this.item,
    required this.onTap,
  });

  @override
  State<_NavTapTarget> createState() => _NavTapTargetState();
}

class _NavTapTargetState extends State<_NavTapTarget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressCtrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 400),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(
        parent: _pressCtrl,
        curve: Curves.easeInCirc,
        reverseCurve: const ElasticOutCurve(0.45),
      ),
    );
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) {
        _pressCtrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressCtrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColor.primaryBlue.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Filled vs outline icon swap via AnimatedSwitcher
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Icon(
                  widget.isActive
                      ? widget.item.activeIcon
                      : widget.item.inactiveIcon,
                  key: ValueKey(widget.isActive),
                  size: widget.isActive ? 26 : 24,
                  color: widget.isActive
                      ? AppColor.primaryBlue
                      : AppColor.mutedText,
                ),
              ),
              const SizedBox(height: 4),
              // Label with animated weight + color
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: AppTypography.labelSmall.copyWith(
                  color: widget.isActive
                      ? AppColor.primaryBlue
                      : AppColor.mutedText,
                  fontWeight:
                      widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 10,
                  letterSpacing: 0.2,
                ),
                child: Text(widget.item.label),
              ),
              // Active dot indicator — use Opacity, never animate size to 0
              // (animating w/h to 0 with elastic curve overshoots negative)
              AnimatedOpacity(
                opacity: widget.isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 220),
                child: Container(
                  width: 18,
                  height: 3,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const _NavItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
