import 'package:flutter/material.dart';
import '../extensions/extensions.dart';

class HeartPainter extends CustomPainter {
  final double value;

  HeartPainter({
    required this.value,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final double circleR = size.height / 4;
    final double maxHeight = size.height * .95;

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path heartRightPath = Path()
      ..moveTo(size.width - circleR * 2, circleR)
      ..arcTo(
        Rect.fromLTWH(
          size.width - circleR * 2,
          0,
          circleR * 2,
          circleR * 2,
        ),
        180.deg2rad,
        225.deg2rad,
        true,
      )
      ..quadraticBezierTo(
        size.width - circleR * 2,
        maxHeight * .9,
        size.width - circleR * 2,
        maxHeight,
      )
      // ..lineTo(
      //   size.width - circleR * 2,
      //   maxHeight,
      // )
      ..lineTo(size.width - circleR * 2, circleR);

    canvas.drawPath(heartRightPath, paint);

    Path heartLeftPath = Path()
      ..moveTo(circleR * 2, circleR)
      ..arcTo(
        Rect.fromLTWH(
          0,
          0,
          circleR * 2,
          circleR * 2,
        ),
        0.deg2rad,
        -225.deg2rad,
        true,
      )
      ..quadraticBezierTo(
        circleR * 2,
        maxHeight * .9,
        circleR * 2,
        maxHeight,
      )
      ..lineTo(circleR * 2, circleR);

    canvas.drawPath(heartLeftPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
