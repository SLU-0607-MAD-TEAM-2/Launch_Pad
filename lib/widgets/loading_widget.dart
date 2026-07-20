import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/app_theme.dart';

/// LaunchPadLoading — premium 3-dot pulse loader with orbital ring.
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

class _LaunchPadLoadingState extends State<LaunchPadLoading>
    with TickerProviderStateMixin {
  late AnimationController _orbitCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _dotsCtrl;

  @override
  void initState() {
    super.initState();
    _orbitCtrl = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _pulseCtrl = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);

    _dotsCtrl = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _orbitCtrl.dispose();
    _pulseCtrl.dispose();
    _dotsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOrbit(),
          const SizedBox(height: 20),
          _buildDots(),
          const SizedBox(height: 10),
          Text(
            widget.message,
            style: AppTypography.labelMedium.copyWith(
              color: AppColor.mutedText,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    if (widget.isOverlay) {
      return Container(
        color: AppColor.white.withValues(alpha: 0.85),
        child: body,
      );
    }
    return body;
  }

  Widget _buildOrbit() {
    return AnimatedBuilder(
      animation: Listenable.merge([_orbitCtrl, _pulseCtrl]),
      builder: (context, _) {
        final pulse = 0.88 + 0.12 * math.sin(_pulseCtrl.value * math.pi);
        return Transform.scale(
          scale: pulse,
          child: SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer orbit ring with gradient arc
                CustomPaint(
                  size: const Size(72, 72),
                  painter: _ArcRingPainter(
                    progress: _orbitCtrl.value,
                    color: AppColor.primaryBlue,
                  ),
                ),
                // Core icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColor.primaryBlue, AppColor.accentCyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryBlue.withValues(alpha: 0.4),
                        blurRadius: 14,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Iconsax.flash_circle,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDots() {
    return AnimatedBuilder(
      animation: _dotsCtrl,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final phase = i / 3;
            final t = (_dotsCtrl.value - phase + 1.0) % 1.0;
            final opacity = (math.sin(t * math.pi)).clamp(0.2, 1.0);
            final scale =
                0.7 + 0.3 * (math.sin(t * math.pi)).clamp(0.0, 1.0);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        AppColor.primaryBlue.withValues(alpha: opacity),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _ArcRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _ArcRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Rotating gradient arc
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [color.withValues(alpha: 0.1), color],
        startAngle: 0,
        endAngle: math.pi * 1.2,
        transform: GradientRotation(
            progress * 2 * math.pi - math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      progress * 2 * math.pi - math.pi / 2,
      math.pi * 1.2,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_ArcRingPainter old) =>
      old.progress != progress || old.color != color;
}
