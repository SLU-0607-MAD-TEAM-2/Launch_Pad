import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text('Explore', style: AppTypography.displaySmall),
              const SizedBox(height: 20),
              _categoryCard('Hackathons', Icons.code_rounded, AppGradients.cardPresets[0]),
              const SizedBox(height: 12),
              _categoryCard('Startup Jobs', Icons.business_center_rounded, AppGradients.cardPresets[1]),
              const SizedBox(height: 12),
              _categoryCard('Co-founder Matching', Icons.group_add_rounded, AppGradients.cardPresets[2]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryCard(String title, IconData icon, List<Color> colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppShapes.cardRadiusLarge),
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        border: Border.all(color: AppColor.stroke),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: AppColor.primary),
          const SizedBox(width: 16),
          Text(title, style: AppTypography.titleMedium),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.textSecondary),
        ],
      ),
    );
  }
}
