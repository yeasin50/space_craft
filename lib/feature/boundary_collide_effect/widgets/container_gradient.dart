import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/entities/vector2.dart';
import '../../../core/utils/utils.dart';
import '../providers/collide_effect_provider.dart';

class GlowingContainer extends StatefulWidget {
  const GlowingContainer({
    Key? key,
    required this.center,
    required this.side,
    this.colorSet,
    this.duration = const Duration(milliseconds: 70),
  }) : super(key: key);

  final Vector2? center;
  final BoundarySide side;
  final List<Color>? colorSet;
  final Duration duration;

  @override
  State<GlowingContainer> createState() => _GlowingContainerState();
}

class _GlowingContainerState extends State<GlowingContainer> {
  late List<Color> colorSet;
  Alignment? began, end;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initSide();
    _initColorTransformation();
  }

  initSide() {
    switch (widget.side) {
      case BoundarySide.top:
        began = Alignment.topCenter;
        end = Alignment.bottomCenter;
        break;
      case BoundarySide.bottom:
        began = Alignment.bottomCenter;
        end = Alignment.topCenter;
        break;
      case BoundarySide.right:
        began = Alignment.centerRight;
        end = Alignment.centerLeft;
        break;

      case BoundarySide.left:
        began = Alignment.centerLeft;
        end = Alignment.centerRight;
        break;
      default:
    }
  }

  void _initColorTransformation() {
    //no need to reduce the opacity on 1st hit, it is not that bad 😄
    colorSet = widget.colorSet ??
        colorSet0; // for 1st build, `.toList()` to create new one

    _timer = Timer.periodic(
      widget.duration,
      (timer) {
        colorSet = colorSet
            .map(
              (color) => changeColorHue(
                color: color,
                increaseBy: 12,
              ).withOpacity(.5),
            )
            .toList();
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          tileMode: TileMode.mirror,
          begin: began ?? Alignment.centerLeft,
          end: end ?? Alignment.centerRight,
          colors: colorSet,
        ),
      ),
    );
  }
}
