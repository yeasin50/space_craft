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
    const radius = Radius.elliptical(13, 50);

    for (double x = size.width * .2; x < size.width * .8; x += blocWidth) {
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, 0, blocWidth * .8, size.height),

          //FIXME: fix the logic
          bottomLeft: Radius.elliptical(shiftValue ?? 1 * 30, 50),
          bottomRight: Radius.elliptical(30 * (1 - (shiftValue ?? 0)), 50),
        ),
      );
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
