import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/home/main_shell.dart';
import 'utils/app_theme.dart';

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
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget builder;
        switch (settings.name) {
          case '/':
            builder = const SplashScreen();
            break;
          case '/login':
            builder = const LoginScreen();
            break;
          case '/home':
            builder = const MainShell();
            break;
          case '/edit_profile':
            builder = EditProfileScreen(
              initialName: 'John Doe',
              initialLocation: 'San Francisco, CA',
              initialBio: 'Passionate UI/UX designer building beautiful developer tooling interfaces.',
              initialRole: 'UI/UX Designer',
              initialSkills: 'Dart, Flutter',
              initialGithub: 'https://github.com/johndoe',
              initialLinkedin: 'https://linkedin.com/in/johndoe',
              onSave: (name, location, bio, role, skills, github, linkedin) {},
            );
            break;
          default:
            builder = const SplashScreen();
        }

        // Soft slide and fade navigation transition
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => builder,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideTween = Tween<Offset>(
              begin: const Offset(0.04, 0.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            );

            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: slideTween,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 320),
        );
      },
    );
  }
}
