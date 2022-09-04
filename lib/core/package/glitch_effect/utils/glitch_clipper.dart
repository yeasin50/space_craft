import 'package:flutter/material.dart';
import 'dart:math' as math;

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;
  final random = math.Random();
  @override
  getClip(Size size) {
    Path path = Path();
    double y = randomStep;
    while (y < size.height) {
      double yRandom = randomStep;
      double x = randomStep;

      while (x < size.width) {
        double xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y.toDouble()),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant GlitchClipper oldClipper) => this != oldClipper;
}
