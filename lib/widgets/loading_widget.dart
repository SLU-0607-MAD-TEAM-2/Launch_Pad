import 'dart:math' as math;
import 'package:flutter/material.dart';

class LaunchPadLoading extends StatefulWidget {
  final String message;
  final bool isOverlay;

  const LaunchPadLoading({
    super.key,
    this.message = 'Loading...',
    this.isOverlay = false,
  });

  @override
  State<LaunchPadLoading> createState() => _LaunchPadLoadingState();
}

class _LaunchPadLoadingState extends State<LaunchPadLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    Widget body = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Elegant Orbit + Pulse Animation
          Stack(
            alignment: Alignment.center,
            children: [
              // Orbiting circle
              RotationTransition(
                turns: _controller,
                child: CustomPaint(
                  size: const Size(64, 64),
                  painter: _OrbitPainter(color: primaryColor),
                ),
              ),
              // Inner pulsing dot
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final scale = 0.8 + 0.25 * math.sin(_controller.value * 2 * math.pi);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          // Loading Message
          Text(
            widget.message,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );

    if (widget.isOverlay) {
      return Container(
        color: Colors.black.withValues(alpha: 0.35),
        child: BackdropFilter(
          filter: const ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
          child: body,
        ),
      );
    }

    return body;
  }
}

class _OrbitPainter extends CustomPainter {
  final Color color;

  _OrbitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background thin track
    canvas.drawCircle(center, radius, paint);

    // Draw active orbiting arc
    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi / 2, // 90 degree arc
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
