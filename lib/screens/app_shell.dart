import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';
import '../widgets/launchpad_bottom_nav.dart';
import 'home/discovery_screen.dart';
import 'home/matches_screen.dart';
import 'profile/profile_screen.dart';
import 'settings/settings_screen.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();
    return Scaffold(
      body: IndexedStack(
        index: nav.currentIndex,
        children: const [
          DiscoveryScreen(),
          MatchesScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: const LaunchPadBottomNav(),
    );
  }
}
