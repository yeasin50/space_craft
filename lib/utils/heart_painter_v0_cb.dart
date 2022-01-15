import 'package:flutter/material.dart';
import '../extensions/extensions.dart';
import 'dart:ui' as ui;

///: fix draw for small version, moved to next Paint [HeartPainterQB]
class HeartPainter extends CustomPainter {
  /// progres value [0.0 - 1.0]
  final double value;

  HeartPainter({
    required this.value,
  }) : assert(
          value > -1.0 && value <= 1,
          "HeartPainter value must be withing 0.0-1.0",
        );
  @override
  void paint(Canvas canvas, Size size) {
    final double circleR = size.height / 4;
    final double maxHeight = size.height * .95;

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

    //to fix divider
    canvas.drawLine(
      Offset(circleR * 2, circleR),
      Offset(circleR * 2, maxHeight),
      paint,
    );

    // //* midle path
    // final double lineWidth = size.height * .03 * (1 - value);

    // final midPoint = Offset(size.width / 2, maxHeight / 2);

    // Path path = Path()
    //   // top left line
    //   ..moveTo(circleR * 2, circleR)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(circleR * 2, circleR + lineWidth)
    //   //mid left
    //   ..moveTo(circleR * 2, maxHeight / 2 - lineWidth / 2)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(circleR * 2, maxHeight / 2 + lineWidth / 2)
    //   //bottom left part
    //   ..moveTo(circleR * 2, maxHeight - lineWidth)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(circleR * 2, maxHeight)
    //   //topRight
    //   ..moveTo(size.width - circleR * 2, circleR)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(size.width - circleR * 2, circleR + lineWidth)
    //   // certerRight
    //   ..moveTo(size.width - circleR * 2, maxHeight / 2 - lineWidth / 2)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(size.width - circleR * 2, maxHeight / 2 + lineWidth / 2)
    //   //bottom left part
    //   ..moveTo(size.width - circleR * 2, maxHeight - lineWidth)
    //   ..lineTo(midPoint.dx, midPoint.dy)
    //   ..lineTo(size.width - circleR * 2, maxHeight);

    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
