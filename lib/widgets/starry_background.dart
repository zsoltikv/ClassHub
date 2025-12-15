import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// star model to store position, size, velocity, and glow
class Star {
  Offset position;
  double size;
  double dx; // horizontal speed
  double dy; // vertical speed
  double glow;
  double brightness;

  Star({
    required this.position,
    required this.size,
    required this.dx,
    required this.dy,
    required this.glow,
    required this.brightness,
  });
}

// custom painter to draw stars with subtle bloom/glow
class StarryBackgroundPainter extends CustomPainter {
  final List<Star> stars;
  final Color backgroundColor;
  final Color starColor;

  StarryBackgroundPainter({required this.stars, required this.backgroundColor, required this.starColor});

  @override
  void paint(Canvas canvas, Size size) {
    // fill background black
    final bgPaint = Paint()..color = backgroundColor;
    canvas.drawRect(Offset.zero & size, bgPaint);

    for (var star in stars) {
      // glow
      final glowPaint = Paint()
        ..color = starColor.withValues(alpha: star.brightness * 0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawCircle(star.position, star.size + star.glow, glowPaint);

      // main star
      final paint = Paint()..color = starColor.withValues(alpha: star.brightness);
      canvas.drawCircle(star.position, star.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StarryBackgroundPainter oldDelegate) => true;
}

// widget for animated starry background
class StarryBackground extends StatefulWidget {
  const StarryBackground({super.key});

  @override
  State<StarryBackground> createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];
  final int numStars = 120;
  final Random _random = Random();

  late double screenWidth;
  late double screenHeight;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..addListener(() {
        _updateStars();
      });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;

      for (int i = 0; i < numStars; i++) {
        _stars.add(
          Star(
            position: Offset(
              _random.nextDouble() * screenWidth,
              _random.nextDouble() * screenHeight,
            ),
            size: _random.nextDouble() * 1.2 + 0.5,
            dx: (_random.nextDouble() - 0.5) * 0.2, // small horizontal drift
            dy: (_random.nextDouble() - 0.5) * 0.2, // small vertical drift
            glow: _random.nextDouble() * 2 + 1,
            brightness: _random.nextDouble() * 0.5 + 0.5,
          ),
        );
      }

      _controller.repeat();
    });
  }

  void _updateStars() {
    if (!mounted) return;

    for (var star in _stars) {
      // move star in both directions
      double newX = star.position.dx + star.dx;
      double newY = star.position.dy + star.dy;

      // wrap around screen edges
      if (newX < 0) newX = screenWidth;
      if (newX > screenWidth) newX = 0;
      if (newY < 0) newY = screenHeight;
      if (newY > screenHeight) newY = 0;

      star.position = Offset(newX, newY);

      // twinkle
      star.brightness += (_random.nextDouble() - 0.5) * 0.02;
      star.brightness = star.brightness.clamp(0.5, 1.0);
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: StarryBackgroundPainter(stars: _stars, backgroundColor: AppColors.background(context), starColor: AppColors.text(context)),
    );
  }
}
