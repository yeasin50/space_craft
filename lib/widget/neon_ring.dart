import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

///```
///This is an example with default value
///....
/// NeonRingWidget(
/// key: UniqueKey(),
///   colorSet: colorSet0,
///   rotation: false,
///   radius: 150,
///   frameThickness: 16,
// ),
/// ...
///```

/// animated colorfull rign widget that will be `width=height=radius*2`. change colors based on [duration] you provide, default `Duration(milliseconds: 150),` with `Curves.ease`
class NeonRingWidget extends StatefulWidget {
  /// rign radius, use to draw circle[Container],
  final double radius;

  /// ColorSet that will change over time using[changeColorHue]
  final List<Color> colorSet;

  ///Duration of animation default=`Duration(milliseconds: 150),` pefer 50mili sec
  final Duration duration;

  /// default Curve= `Curves.ease`
  final Curve curve;

  ///border width, for null value it will use [RingPath]'s `borderThickness:16px`
  final double? frameThickness;

  /// rotate ring widget default is true
  final bool rotation;

  /// rotate transform by  `rotationIncrementRate` degree on every [duration] while `rotation:true`
  /// default [rotationIncrementRate] is 5 degree
  final double rotationIncrementRate;

  const NeonRingWidget({
    Key? key,
    required this.colorSet,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.ease,
    this.frameThickness,
    required this.radius,
    this.rotation = true,
    this.rotationIncrementRate = 5.0,
  }) : super(key: key);

  @override
  State<NeonRingWidget> createState() => _NeonRingWidgetState();
}

class _NeonRingWidgetState extends State<NeonRingWidget> {
  Timer? _timer;

  double rotateAngel = 0;

  late List<Color> colorSet;

  @override
  void initState() {
    super.initState();
    _initColorTransformation();
  }

  void _initColorTransformation() {
    colorSet = widget.colorSet; // for 1st build, `.toList()` to create new one

    _timer = Timer.periodic(
      widget.duration,
      (timer) {
        colorSet = colorSet
            .map(
              (color) => changeColorHue(
                color: color,
                increaseBy: 1,
              ),
            )
            .toList();

        if (widget.rotation) {
          rotateAngel += deg2rad(widget.rotationIncrementRate);
        }
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
    return Transform.rotate(
      angle: rotateAngel,
      child: ClipPath(
        clipper: RingPath(),
        child: Container(
          //todo:add blur
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colorSet,
            ),
          ),
          width: widget.radius * 2,
          height: widget.radius * 2,
        ),
      ),
    );
  }
}
