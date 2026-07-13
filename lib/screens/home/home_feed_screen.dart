import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/design_colors.dart';
import '../../providers/swipe_provider.dart';
import '../messages/messages_list_screen.dart';
import '../profile/profile_screen.dart';
import 'swipe_discovery_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  final SwipeProvider swipeProvider;

  const HomeFeedScreen({super.key, required this.swipeProvider});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  int _currentIndex = 0;

  static const _navIcons = [
    Icons.explore_outlined,
    Icons.forum_outlined,
    Icons.person_outline,
  ];

  static const _navLabels = ['Discover', 'Messages', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColors.background,
      body: ChangeNotifierProvider<SwipeProvider>.value(
        value: widget.swipeProvider,
        child: IndexedStack(
          index: _currentIndex,
          children: [
            const SwipeDiscoveryScreen(),
            const MessagesListScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: DesignColors.border)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) {
                final isSelected = _currentIndex == i;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? DesignColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _navIcons[i],
                          color: isSelected ? DesignColors.primary : DesignColors.textSecondary,
                          size: 22,
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 6),
                          Text(_navLabels[i], style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600, color: DesignColors.primary,
                          )),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
