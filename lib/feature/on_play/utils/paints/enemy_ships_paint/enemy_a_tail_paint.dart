import 'package:flutter/cupertino.dart';

class EnemyTailClipPath extends CustomClipper<Path> {
  /// a little wave the tail using radius based on this [shiftValue]
  final double? shiftValue;

  EnemyTailClipPath({
    this.shiftValue,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();

    final blocWidth = size.width * .07;
    const double wadeableTailHeight = 75;

    for (double x = size.width * .2; x < size.width * .8; x += blocWidth) {
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, 0, blocWidth * .8, size.height),
          bottomLeft:
              Radius.elliptical(30 * (shiftValue ?? .5), wadeableTailHeight),
          bottomRight: Radius.elliptical(
              30 * (1 - (shiftValue ?? .5)), wadeableTailHeight),
        ),
      );
    }

    return path;
  }

  @override
  bool shouldReclip(EnemyTailClipPath oldClipper) =>
      oldClipper.shiftValue != shiftValue;
}
