import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _hoverController;
  late final AnimationController _liftoffController;

  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _hoverAnimation;
  late final Animation<double> _liftoffAnimation;

  bool _isLiftoffStarted = false;

  @override
  void initState() {
    super.initState();

    // 1. Intro Scale & Fade (1 second)
    _introController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutBack),
    );

    // 2. Hover Oscillation (1.5 seconds repeating)
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _hoverAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    // Start hover after intro finishes
    _introController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_isLiftoffStarted) {
        _hoverController.repeat(reverse: true);
      }
    });

    // 3. Lift-off transition (500ms)
    _liftoffController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _liftoffAnimation = Tween<double>(begin: 0.0, end: -800.0).animate(
      CurvedAnimation(parent: _liftoffController, curve: Curves.easeInBack),
    );

    _liftoffController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    // Start the intro animation
    _introController.forward();

    // Schedule Lift-off after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _isLiftoffStarted = true;
        });
        _hoverController.stop();
        _liftoffController.forward();
      }
    });
  }

  @override
  void dispose() {
    _introController.dispose();
    _hoverController.dispose();
    _liftoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC), // Crisp background
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _introController,
            _hoverController,
            _liftoffController,
          ]),
          builder: (context, child) {
            // Combine vertical hover offset and liftoff offset
            final verticalOffset = _hoverAnimation.value + _liftoffAnimation.value;

            return Transform.translate(
              offset: Offset(0, verticalOffset),
              child: Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Handshake-rocket logo
                      Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.rocket_launch,
                          color: Color(0xFF0052FF),
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'LAUNCHPAD',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF0052FF), // Electric Blue
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'CONNECT. BUILD. LAUNCH.',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF475569),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
