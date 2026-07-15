import 'package:flutter/material.dart';

class LaunchPadLoading extends StatefulWidget {
  const LaunchPadLoading({super.key});

  @override
  State<LaunchPadLoading> createState() => _LaunchPadLoadingState();
}

class _LaunchPadLoadingState extends State<LaunchPadLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0052FF)),
              strokeWidth: 3,
            ),
          ),
          RotationTransition(
            turns: _controller,
            child: Image.asset(
              'assets/images/logo.png',
              width: 44,
              height: 44,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.rocket_launch,
                color: Color(0xFF0052FF),
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
