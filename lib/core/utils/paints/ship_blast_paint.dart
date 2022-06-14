import 'package:flutter/material.dart';

///```
///  return ScaleTransition(
///      scale: _animationBlast,
///      alignment: Alignment.topCenter,
///      child: CustomPaint(
///        size: widget.size,
///      painter: ShipBlastPainter(),
///     ),
///   );
///```
/// ship engine blast/fire used by [ShipBlast] widget, animating scale provide the view
class ShipBlastPainter extends CustomPainter {
  /// fireShade/outside/ borderSide color, default ` Colors.lightBlueAccent.shade100`
  final Color outerColor;

  /// fireColor/ inside color, default `Colors.cyanAccent`
  final Color innerColor;

  ShipBlastPainter({
    Color? outerColor,
    Color? innerColor,
  })  : outerColor = outerColor ?? Colors.lightBlueAccent.shade100,
        innerColor = innerColor ?? Colors.cyanAccent;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          outerColor,
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
      ..shader = LinearGradient(
        colors: [
          innerColor,
          Colors.white,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.35, 6.0],
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
