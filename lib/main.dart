import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/swipe_provider.dart';
import 'providers/matches_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/discovery_provider.dart';
import 'services/mock_api_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/splash_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/feedback/feedback_screen.dart';
import 'screens/home/main_shell.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = MockApiService();
  await apiService.loadAll();
  runApp(LaunchPadApp(apiService: apiService));
}

class LaunchPadApp extends StatelessWidget {
  final MockApiService apiService;

  const LaunchPadApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SwipeProvider(apiService)),
        ChangeNotifierProvider(create: (_) => MatchesProvider(apiService)),
        ChangeNotifierProvider(create: (_) => ChatProvider(apiService)),
        ChangeNotifierProvider(create: (_) => DiscoveryProvider(apiService)),
      ],
      child: MaterialApp(
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
            case '/feedback':
              builder = const FeedbackScreen();
              break;
            case '/edit_profile':
              builder = EditProfileScreen(
                initialName: 'John Doe',
                initialLocation: 'San Francisco, CA',
                initialBio:
                    'Passionate UI/UX designer building beautiful developer tooling interfaces.',
                initialRole: 'UI/UX Designer',
                initialSkills: 'Dart, Flutter',
                initialGithub: 'https://github.com/johndoe',
                initialLinkedin: 'https://linkedin.com/in/johndoe',
                onSave:
                    (name, location, bio, role, skills, github, linkedin) {},
              );
              break;
            default:
              builder = const SplashScreen();
          }

          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) => builder,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
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
      ),
    );
  }
}
