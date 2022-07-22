import 'package:flutter/material.dart';
import 'package:space_craft/core/entities/entities.dart';

import '../providers/collide_effect_provider.dart';

class GlowEffect extends StatefulWidget {
  final BoundarySide side;
  final double thickness;
  final PlayerBCollideEffect effectNotifier;
  const GlowEffect({
    Key? key,
    required this.side,
    this.thickness = 10,
    required this.effectNotifier,
  }) : super(key: key);

  @override
  State<GlowEffect> createState() => _GlowEffectState();
}

class _GlowEffectState extends State<GlowEffect> {
  double? top, left, bottom, right;
  double? height, width;

  late final Vector2? point = widget.effectNotifier.collidePoint;

  void initData() {
    switch (widget.side) {
      case BoundarySide.top:
        top = 0;
        left = 0;
        right = 0;
        height = widget.thickness;
        break;
      case BoundarySide.right:
        top = 0;
        right = 0;
        bottom = 0;
        width = widget.thickness;
        break;
      case BoundarySide.bottom:
        bottom = 0;
        left = 0;
        right = 0;
        height = widget.thickness;
        break;
      case BoundarySide.left:
        left = 0;
        top = 0;
        bottom = 0;
        width = widget.thickness;
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key("_GlowEffectState"),
      children: [
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            height: height,
            width: width,
            color: Colors.amber.withOpacity(.3),
            alignment: Alignment.center,
          ),
        ),
        //todo, use align/provide positioned value else it will block UI
        Positioned(
          // left: point?.dX,
          // top: point?.dY,
          key: const ValueKey("point "),
          child: Container(
            height: height ?? width ?? 0 * .2,
            width: height ?? width ?? 0 * .2,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
