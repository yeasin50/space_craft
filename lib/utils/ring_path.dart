import 'package:flutter/widgets.dart';

/// draw path like o, used [CustomClipper]<[Path]>
class RingPath extends CustomClipper<Path> {
  /// ring/border thickness, defaul 10% on last like `0`
  final double gap;
  RingPath({
    this.gap = .1,
  });
  @override
  Path getClip(Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2;
    Path path1 = Path();
    path1.fillType = PathFillType.evenOdd;
    path1.addOval(Rect.fromCircle(center: center, radius: radius));
    path1.addOval(Rect.fromCircle(center: center, radius: radius * (1 - gap)));

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
