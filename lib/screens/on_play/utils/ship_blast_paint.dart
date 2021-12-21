import 'package:flutter/material.dart';

class ShipBlastPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.lightBlueAccent.shade100,
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.65, 1.0],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final Path outerPath = Path()
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(size.width, 0, size.width, size.height / 4)
      ..quadraticBezierTo(size.width, size.height, size.width / 2, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height / 4)
      ..quadraticBezierTo(0, 0, size.width / 2, 0);

    canvas.drawPath(outerPath, paint);

    //** inner Fire */

    final topPort = size.height * .1;
    Paint innerPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Colors.cyanAccent,
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.35, 6.0],
      ).createShader(
        Rect.fromCenter(
          width: size.width * .6,
          height: size.height * .7,
          center: Offset(size.width / 2, size.height / 2),
        ),
      );

    Path innerPath = Path()
      ..moveTo(size.width / 2, size.height * .7) //down point to start
      // right side
      ..quadraticBezierTo(
        size.width,
        topPort,
        size.width / 2,
        topPort,
      )
      // left side
      ..moveTo(size.width / 2, size.height * .7)
      ..quadraticBezierTo(
        0,
        topPort,
        size.width / 2,
        topPort,
      )
      ..close();
    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
