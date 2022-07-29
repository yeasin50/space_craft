import 'package:flutter/cupertino.dart';

class EnemyTailClipPath extends CustomClipper<Path> {
  final int numberOfTail;
  final bool isShifted;

  EnemyTailClipPath({
    required this.isShifted,
    this.numberOfTail = 12,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();

    final midPoint = size.width;
    double blocWidth = size.width * .2;

    for( double   x= size.width * .2; x< size.width * .8;   )
    path.addRect(
      Rect.fromLTRB(, 0,, size.height),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
