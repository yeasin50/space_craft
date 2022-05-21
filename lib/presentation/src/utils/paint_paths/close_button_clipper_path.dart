import 'package:flutter/cupertino.dart';

/// this will provide the shape of ``X`` as close button with hole
//maybe I can just use two line while it rotates
//TODO: change the shape
class CloseButtonCustomClipperPath extends CustomClipper<Path> {
  /// width of close \ depend on width
  /// default is 10%
  final double thicknessRatio;
  CloseButtonCustomClipperPath({
    this.thicknessRatio = .1,
  });

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width * (1 - thicknessRatio), size.height)
    ..lineTo(size.width, size.height)
    ..lineTo(size.width * thicknessRatio, 0)
    ..lineTo(0, 0) // done `\`
    ..moveTo(0, size.height)
    ..lineTo(size.width * (1 - thicknessRatio), 0)
    ..lineTo(size.width, 0)
    ..lineTo(size.width * thicknessRatio, size.height)
    ..lineTo(0, size.height)
    ..lineTo(size.width * (1 - thicknessRatio), 0)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
