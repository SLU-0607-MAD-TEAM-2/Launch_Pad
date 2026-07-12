import 'package:flutter/material.dart';

// Screen imports (to be implemented in Week 2)
// import 'screens/auth/login_screen.dart';
// import 'screens/home/home_feed_screen.dart';

void main() {
  runApp(const LaunchPadApp());
}

class LaunchPadApp extends StatelessWidget {
  const LaunchPadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaunchPad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      // Week 2: replace with LoginScreen()
      home: const Scaffold(
        body: Center(
          child: Text('LaunchPad - Week 1 Scaffold'),
        ),
      ),
    );
  }
}
