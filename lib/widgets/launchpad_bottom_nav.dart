import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';
import '../theme/theme.dart';

class LaunchPadBottomNav extends StatelessWidget {
  const LaunchPadBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.radiusXL),
        color: AppColor.surface.withValues(alpha: 0.7),
        border: Border.all(color: AppColor.stroke, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppShapes.radiusXL),
        child: BottomNavigationBar(
          currentIndex: nav.currentIndex,
          onTap: nav.setIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.textSecondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Discovery'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Matches'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
