import 'package:flutter/cupertino.dart';

class EnemyTailClipPath extends CustomClipper<Path> {
  /// a little wave the tail using radius based on this [isShifted]
  final bool isShifted;

  EnemyTailClipPath({
    required this.isShifted,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();

    final blocWidth = size.width * .07;

    for (double x = size.width * .2; x < size.width * .8; x += blocWidth) {
      const radius = Radius.elliptical(13, 50);
      path.addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(x, 0, blocWidth * .8, size.height),
          bottomLeft: isShifted ? radius : Radius.zero,
          bottomRight: isShifted ? Radius.zero : radius,
        ),
      );
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
