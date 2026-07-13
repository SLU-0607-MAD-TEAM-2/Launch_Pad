import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/design_colors.dart';
import '../../providers/swipe_provider.dart';

class SwipeDiscoveryScreen extends StatelessWidget {
  const SwipeDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SwipeProvider>(
      builder: (context, provider, _) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [DesignColors.primary, DesignColors.secondary],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.rocket_launch, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text('Discover', style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700, color: DesignColors.textPrimary,
                    )),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: DesignColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite, size: 14, color: DesignColors.primary),
                          const SizedBox(width: 4),
                          Text('${provider.likedCount}', style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600, color: DesignColors.primary,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: provider.isEmpty
                    ? _buildEmpty(provider)
                    : _buildCard(context, provider),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty(SwipeProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 64, color: DesignColors.textSecondary.withValues(alpha: 0.4)),
          const SizedBox(height: 16),
          const Text('No more projects', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: DesignColors.textPrimary,
          )),
          const SizedBox(height: 8),
          const Text('Check back later for new opportunities', style: TextStyle(
            fontSize: 14, color: DesignColors.textSecondary,
          )),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => provider.reset(),
            style: ElevatedButton.styleFrom(
              backgroundColor: DesignColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, SwipeProvider provider) {
    final project = provider.current!;
    final tags = project.skillsRequired.take(4).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      gradient: LinearGradient(
                        colors: [
                          DesignColors.secondary,
                          DesignColors.primary,
                        ],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: 16, right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              project.industry.isNotEmpty ? project.industry : project.stage,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16, left: 20,
                          child: Row(
                            children: [
                              Container(
                                width: 36, height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.person, size: 20, color: Colors.white.withValues(alpha: 0.8)),
                              ),
                              const SizedBox(width: 8),
                              Text(project.founderName, style: const TextStyle(
                                color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500,
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(project.title, style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700, color: DesignColors.textPrimary,
                              )),
                            ),
                            if (!project.isRemote)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: DesignColors.warning.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(project.location, style: const TextStyle(
                                  fontSize: 10, color: DesignColors.warning, fontWeight: FontWeight.w500,
                                )),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(project.description, style: const TextStyle(
                          fontSize: 13, color: DesignColors.textSecondary, height: 1.4,
                        ), maxLines: 3, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.science_outlined, size: 14, color: DesignColors.textSecondary.withValues(alpha: 0.7)),
                            const SizedBox(width: 4),
                            Text(project.stage.toUpperCase(), style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600,
                              color: DesignColors.textSecondary.withValues(alpha: 0.7), letterSpacing: 0.5,
                            )),
                            const SizedBox(width: 16),
                            Icon(Icons.wifi_tethering, size: 14, color: DesignColors.textSecondary.withValues(alpha: 0.7)),
                            const SizedBox(width: 4),
                            Text(project.isRemote ? 'Remote' : 'On-site', style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600,
                              color: DesignColors.textSecondary.withValues(alpha: 0.7),
                            )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8, runSpacing: 6,
                          children: tags.map((s) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: DesignColors.lightGray,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(s, style: const TextStyle(fontSize: 12, color: DesignColors.textPrimary)),
                          )).toList(),
                        ),
                        if (project.rolesNeeded.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 6, runSpacing: 4,
                            children: project.rolesNeeded.map((r) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: DesignColors.secondaryContainer.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(r, style: const TextStyle(fontSize: 11, color: DesignColors.secondary, fontWeight: FontWeight.w500)),
                            )).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => provider.swipeLeft(),
                    child: Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12)],
                      ),
                      child: const Icon(Icons.close, size: 28, color: DesignColors.error),
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: () => provider.swipeRight(),
                    child: Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        color: DesignColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: DesignColors.primary.withValues(alpha: 0.3), blurRadius: 12)],
                      ),
                      child: const Icon(Icons.favorite, size: 28, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
