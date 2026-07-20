import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/app_theme.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBorder;

  const AppTopBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTypography.titleMedium),
      centerTitle: true,
      backgroundColor: AppColor.screenBgLight,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      actions: actions,
      bottom: showBorder
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: AppColor.borderHairline.withValues(alpha: 0.4),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (showBorder ? 1 : 0));
}

/// Reusable back button using Iconsax icons.
class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.screenBgLight,
          border: Border.all(
            color: AppColor.borderHairline.withValues(alpha: 0.5),
          ),
        ),
        child: const Icon(
          Iconsax.arrow_left,
          size: 18,
          color: AppColor.headingDark,
        ),
      ),
    );
  }
}
