import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/nav_provider.dart';
import '../home/discovery_screen.dart';
import '../messages/messages_list_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
import '../../widgets/launchpad_bottom_nav.dart';
import '../../utils/app_theme.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => MainShellState();
}

class MainShellState extends State<MainShell> {
  void setSelectedIndex(int index) {
    context.read<NavProvider>().setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavProvider>();

    return Scaffold(
      backgroundColor: AppColor.screenBgLight,
      body: IndexedStack(
        index: nav.currentIndex,
        children: const [
          DiscoveryScreen(),
          MessagesListScreen(),
          ProfileScreen(),
          SettingsScreen(),
        ],
      ),
      // Floating bottom nav — no built-in BottomNavigationBar
      bottomNavigationBar: const LaunchPadBottomNav(),
    );
  }
}
