import 'package:flutter/material.dart';

class HeartPainterQB extends CustomPainter {
  final double value;

  HeartPainterQB({
    required this.value,
  }) : assert(
          value > -1.0 && value <= 1,
          "HeartPainter value must be withing 0.0-1.0",
        );
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      // ..color = Colors.red
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        colors: const [
          Colors.transparent,
          Colors.red,
        ],
        stops: [
          0.0,
          value,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    // left Side heart paint
    Path leftSidePath = Path()
          ..moveTo(size.width / 2, size.height * .15)
          ..quadraticBezierTo(
            size.width * .68,
            size.height * -.1,
            size.width * .92,
            size.height * .07,
          )
          ..moveTo(
            size.width * .92,
            size.height * .07,
          )
          ..quadraticBezierTo(
            size.width * 1.18,
            size.height * .55,
            size.width * .92,
            size.height * .52,
          )
        // ..quadraticBezierTo(
        //   size.width * .86,
        //   size.height * .74,
        //   size.width * .72,
        //   size.height * .77,
        // )
        // ..quadraticBezierTo(
        //   size.width * .55,
        //   size.height * .95,
        //   size.width * .5,
        //   size.height * .97,
        // )
        ;

    canvas.drawPath(leftSidePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
