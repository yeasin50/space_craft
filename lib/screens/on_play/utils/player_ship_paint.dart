import 'package:flutter/material.dart';

///. not gonna use paint
class PlayerShipPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double height = size.height;
    final double width = size.width;

    Paint paint = Paint()
      ..color = Colors.red
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
    paint.color = Colors.redAccent.withOpacity(.8);
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

    //second bloc
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
    canvas.drawPath(secondBloc, paint);

    //mid part
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
