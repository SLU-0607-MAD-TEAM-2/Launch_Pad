import 'package:flutter/material.dart';
import '../explore/explore_screen.dart';
import '../messages/messages_list_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

/// HomeFeedScreen is an all-in-one home hub widget that provides a
/// secondary tab bar between the four main content areas.
/// This is the body embedded in the main app's Home tab when it
/// needs to be used as a content aggregator.
class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'LaunchPad',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w900,
            color: Color(0xFF0052FF),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF0052FF),
          unselectedLabelColor: const Color(0xFF94A3B8),
          indicatorColor: const Color(0xFF0052FF),
          labelStyle: const TextStyle(
            fontFamily: 'Geist',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          tabs: const [
            Tab(text: 'Explore'),
            Tab(text: 'Messages'),
            Tab(text: 'Profile'),
            Tab(text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ExploreScreen(),
          MessagesListScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
