import 'package:flutter/material.dart';
import '../widget/widget.dart';
import '../provider/provider.dart';

import 'utils.dart';

/// used on [RotateWidget] to paint [RadialGradient] for falling hearth of[HealingObjectNotifier]
///
/// two constructor [HeartPainter] and [HeartPainter.radial]  for Paint GradientHeart based on value[0.0-1.0]
class HeartPainter extends CustomPainter {
  /// progres value [0.0 - 1.0]
  final double value;

  ///heart base/default color is red
  Color color;

  ///show middle path on heart slipt, you need to set size(x*n ,x) to see default is false
  final bool showMiddlePaint;

  //used to create shader
  late final Gradient _gradient;

  /// ```
  /// CustomPaint(
  ///painter: HeartPainter.radial(
  ///  color: Colors.red,
  ///  animationValue: value,
  ///),
  ///),
  /// ```
  /// `animationValue` is used to spread color on canvas
  /// used on [RotateWidget] to paint [RadialGradient] for falling heart
  HeartPainter.radial({
    this.color = Colors.red,
    double? animationValue,
  })  : value = 1.0,
        _gradient = RadialGradient(
          focal: Alignment.center,
          radius: 1.0,
          colors: [
            color.withOpacity(animationValue == null
                ? 1
                : animationValue < .5
                    ? 0.5
                    : animationValue),
            color.withOpacity(.2),
          ],
          stops: [
            animationValue ?? 0,
            .3,
          ],
        ),
        showMiddlePaint = false;

  ///
  /// `value` is define how much heath will be paint from top to bottom
  /// ```
  ///CustomPaint(
  /// painter: HeartPainter.linear(
  ///  color: Colors.red,
  ///  value: value,
  ///),
  /// ```
  ///default construtor of [HeartPainter] required to pass `value` between 0-1 and default `color` of Heart is red
  HeartPainter({
    required this.value,
    this.color = Colors.red,
  })  : showMiddlePaint = false,
        _gradient = LinearGradient(
          colors: [color, Colors.transparent],
          stops: [value, 0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        assert(
          value > -1.0 && value <= 1,
          "HeartPainter value must be withing 0.0-1.0",
        );

  @override
  void paint(Canvas canvas, Size size) {
    final double circleR = size.height / 4;
    final double maxHeight = size.height * .95;

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = _gradient.createShader(
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
        deg2rad(180),
        deg2rad(225),
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
        deg2rad(0),
        deg2rad(-225),
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
      Offset(circleR * 2, maxHeight * .99),
      paint,
    );

    // //* midle path
    // _drawHeartJoint(canvas: canvas, paint: paint, size: size, value: value);
  }

  @override
  bool shouldRepaint(covariant HeartPainter oldDelegate) => this != oldDelegate;

  /// middle paths, heart Joing
  void _drawHeartJoint({
    required Size size,
    required Canvas canvas,
    required Paint paint,
    required double value,
  }) {
    final double circleR = size.height / 4;
    final double maxHeight = size.height * .95;
    final double lineWidth = size.height * .03 * (1 - value);

    final midPoint = Offset(size.width / 2, maxHeight / 2);

    Path path = Path()
      // top left line
      ..moveTo(circleR * 2, circleR)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(circleR * 2, circleR + lineWidth)
      //mid left
      ..moveTo(circleR * 2, maxHeight / 2 - lineWidth / 2)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(circleR * 2, maxHeight / 2 + lineWidth / 2)
      //bottom left part
      ..moveTo(circleR * 2, maxHeight - lineWidth)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(circleR * 2, maxHeight)
      //topRight
      ..moveTo(size.width - circleR * 2, circleR)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(size.width - circleR * 2, circleR + lineWidth)
      // certerRight
      ..moveTo(size.width - circleR * 2, maxHeight / 2 - lineWidth / 2)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(size.width - circleR * 2, maxHeight / 2 + lineWidth / 2)
      //bottom left part
      ..moveTo(size.width - circleR * 2, maxHeight - lineWidth)
      ..lineTo(midPoint.dx, midPoint.dy)
      ..lineTo(size.width - circleR * 2, maxHeight);

    canvas.drawPath(path, paint);
  }
}
