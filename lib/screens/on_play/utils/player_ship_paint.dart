import 'package:flutter/material.dart';

class PlayerShipPaint extends CustomPainter {
  /// top body color[0]
  /// bottom body color[1]
  final List<Color> colors = [
    Colors.red,
    Colors.white,
  ];
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    Paint paint = Paint()
      ..color = colors[0]
      ..style = PaintingStyle.fill;

    //starting from left wing
    Path path = Path()
      ..moveTo(0, height * .5)
      ..quadraticBezierTo(0, height * .35, width * .25, height * .35)
      ..quadraticBezierTo(width * .25, height * .3, width * .4, height * .1)
      ..lineTo(width * .4, height * .5);

    //right wing
    path
      ..moveTo(width, height * .5)
      ..quadraticBezierTo(width, height * .35, width * .75, height * .35)
      ..quadraticBezierTo(width * .75, height * .3, width * .6, height * .1)
      ..lineTo(width * .6, height * .5);
    canvas.drawPath(path, paint);

    //* midle part:top
    paint.color = colors[0].withOpacity(.8);
    final topHeadPath = Path()
      ..moveTo(width / 2, 0)
      //left round
      ..quadraticBezierTo(
        width * .56,
        height * .05,
        width * .55,
        height * .1,
      )
      ..moveTo(width / 2, 0)
      ..quadraticBezierTo(
        width * .44,
        height * .05,
        width * .45,
        height * .1,
      )
      ..quadraticBezierTo(
        width * .5,
        height * .05,
        width * .55,
        height * .1,
      )
      ..close();

    canvas.drawPath(topHeadPath, paint);

    /// second bloc gradientPaint
    Paint secondBlocPaint = Paint()
      ..shader = RadialGradient(colors: [
        Colors.white,
        Colors.amber.withOpacity(.2),
      ], stops: const [
        .5,
        1.0,
      ]).createShader(
        Rect.fromLTRB(
          width * .45,
          height * .1,
          width * .55,
          height * .3,
        ),
      );
    paint.color = Colors.grey;

    Path secondBloc = Path()
      ..moveTo(width * .55, height * .1)
      ..lineTo(width * .55, height * .3)
      ..quadraticBezierTo(
        width * .5,
        height * .35,
        width * .45,
        height * .3,
      )
      ..lineTo(width * .45, height * .1)
      ..quadraticBezierTo(
        width * .5,
        height * .05,
        width * .55,
        height * .1,
      );
    canvas.drawPath(secondBloc, secondBlocPaint);

    //* after middle part

    Paint bottomPaint = Paint()..color = colors[1];

    //bottom curves
    Path bottomBodyPath = Path()
      ..moveTo(0, height * .5)
      ..lineTo(width * .25, height * .5)
      ..lineTo(width, height * .5)
      ..lineTo(width, height)
      ..quadraticBezierTo(
        /// LEFT CURVE
        width,
        height * .5,
        width * .5,
        height * .5,
      )
      ..moveTo(0, height * .5)
      ..lineTo(0, height)
      ..quadraticBezierTo(
        0,
        height * .5,
        width * .5,
        height * .5,
      );

    canvas.drawPath(bottomBodyPath, bottomPaint);

    canvas.drawPath(
      Path()
        ..moveTo(width / 2, height * .25)
        ..lineTo(width * .9, height * .6) //mid-right corner
        ..lineTo(width * .1, height * .6) //mid-left corner
        ..lineTo(width / 2, height * .25) //top
        ..moveTo(width * .1, height * .6)
        // left curve engine fire curve
        ..lineTo(width * .45, height * .9)
        ..lineTo(width * .45, height)
        ..quadraticBezierTo(width * .45, height * .9, width / 2, height * .9)
        ..lineTo(width / 2, height * .6)
        // right curve engine fire curve
        ..moveTo(width / 2, height * .6)
        ..lineTo(width * .9, height * .6)
        ..lineTo(width * .55, height * .9)
        ..lineTo(width * .55, height)
        ..quadraticBezierTo(width * .55, height * .9, width / 2, height * .9),
      Paint()..color = colors[1],
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
