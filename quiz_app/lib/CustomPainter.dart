import 'package:flutter/material.dart';
import 'dart:math';

class ClockPainter extends CustomPainter {
  final int remainingTime;

  ClockPainter(this.remainingTime);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate angle of the fill based on remaining time
    double angle = 2 * pi * (1 - (remainingTime / 5));
    angle = angle.clamp(0.0, 2 * pi); // Clamp between 0 and 2*pi

    // Calculate gradient stops for the color change
    List<Color> gradientColors = [
      Colors.grey[300]!,
      Colors.grey[300]!,
      Colors.white,
      Colors.white
    ];
    List<double> stops = [
      0.0,
      angle / (2 * pi),
      angle / (2 * pi),
      1.0
    ];

    final Gradient gradient = SweepGradient(
      startAngle: -pi / 2,
      endAngle: 2 * pi - pi / 2,
      colors: gradientColors,
      stops: stops,
    );

    final Paint circlePaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2))
      ..style = PaintingStyle.fill;

    final double radius = min(size.width / 2, size.height / 2) - 20;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, circlePaint);

    // Optionally, draw a border around the clock
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, radius, borderPaint);

    final Paint centerDotPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 8, centerDotPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
