import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/discovery_provider.dart';
import '../../theme/theme.dart';
import '../../widgets/swipe_card.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiscoveryProvider>().loadProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final discovery = context.watch<DiscoveryProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('Discover', style: AppTypography.displaySmall),
            const SizedBox(height: 4),
            Text(
              'Swipe right to connect',
              style: AppTypography.bodyMedium.copyWith(color: AppColor.textSecondary),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: discovery.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : discovery.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.inbox_rounded, size: 64, color: AppColor.textSecondary.withValues(alpha: 0.3)),
                              const SizedBox(height: 16),
                              Text('No more profiles', style: AppTypography.titleMedium),
                              const SizedBox(height: 8),
                              PrimaryTextButton(
                                text: 'Refresh',
                                onTap: discovery.reload,
                              ),
                            ],
                          ),
                        )
                      : SwipeCard(
                          profile: discovery.profiles.first,
                          onSwipeLeft: () => discovery.swipeLeft(discovery.profiles.first.id),
                          onSwipeRight: () => discovery.swipeRight(discovery.profiles.first.id),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryTextButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: AppTypography.labelLarge.copyWith(color: AppColor.primary)),
    );
  }
}
