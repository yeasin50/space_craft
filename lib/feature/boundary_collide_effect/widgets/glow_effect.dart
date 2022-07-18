import 'package:flutter/material.dart';

import '../providers/collide_effect_provider.dart';

class GlowEffect extends StatelessWidget {
  final BoundarySide side;
  final double thickness;
  const GlowEffect({
    Key? key,
    required this.side,
    this.thickness = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? top, left, bottom, right;

    double? height, width;

    switch (side) {
      case BoundarySide.top:
        top = 0;
        left = 0;
        right = 0;
        height = thickness;
        break;
      case BoundarySide.right:
        top = 0;
        right = 0;
        bottom = 0;
        width = thickness;
        break;
      case BoundarySide.bottom:
        bottom = 0;
        left = 0;
        right = 0;
        height = thickness;
        break;
      case BoundarySide.left:
        left = 0;
        top = 0;
        bottom = 0;
        width = thickness;
        break;

      default:
    }

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        height: height,
        width: width,
        color: Colors.amber.withOpacity(.3),
      ),
    );
  }
}
