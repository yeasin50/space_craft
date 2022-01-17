import 'package:flutter/material.dart';
import 'package:space_craft/utils/utils.dart';

/// [BulletPaint] is extend by [CustomPainter] to draw the ship's bullet.
///  default color is ship's color
class BulletPaint extends CustomPainter {
  //todo: there are some extra

  /// bullet color
  final Color color;

  /// Bullet move topScreen to bottom,default is `true`
  /// downward=true for enemyShip and playerShip=false
  final bool downward;

  BulletPaint({
    required this.color,
    this.downward = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // there will be empty space above paint, will be used for white shader
    // final startPoint = size.height * .8;

    //* blur type shade around bullet
    // final leftRect = Rect.fromLTRB(
    //   -size.width * .3,
    //   0,
    //   size.width * .5,
    //   size.height * .65,
    // );

    // canvas.drawRect(
    //   leftRect,
    //   Paint()
    //     ..shader = LinearGradient(
    //       begin: Alignment.center,
    //       end: Alignment.topLeft,
    //       colors: [
    //         Colors.green,
    //         Colors.amber,
    //       ],
    //     ).createShader(leftRect),
    // );

    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(.5),
          Colors.white.withOpacity(.1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.2, 1],
      ).createShader(
        Rect.fromLTRB(
          0,
          0,
          size.width,
          size.height * 1.5,
        ),
      );

    ///main bullet path
    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(
        -size.width,
        size.height,
        size.width / 2,
        size.height,
      )
      ..moveTo(size.width / 2, 0)
      ..quadraticBezierTo(
        size.width * 2,
        size.height,
        size.width / 2,
        size.height,
      );

    canvas.drawPath(path, paint);

    ///extra border Gradient
    Paint sidePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(.3),
          Colors.white,
          color.withOpacity(.3),
        ],
      ).createShader(
        Rect.fromLTRB(
          -20,
          -20,
          size.width + 20,
          size.height + 20,
        ),
      );

    //extra border draw
    canvas.drawPath(
      path,
      sidePaint,
    );

    /// midle circle like health form
    final circleMidPoint = size.height * .75;
    Paint circlePaint = Paint()
      ..shader = RadialGradient(colors: [
        color,
        Colors.white70,
        Colors.transparent,
      ], stops: const [
        .4,
        .5,
        1
      ]).createShader(
        Rect.fromLTRB(
          0,
          circleMidPoint,
          size.width,
          size.height,
        ),
      );
    canvas.drawCircle(
      Offset(
        size.width / 2,
        circleMidPoint + size.height * .125,
      ),
      size.width,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
