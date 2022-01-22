import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

///```
///This is an example with default value
///....
/// NeonRingWidget(
///   colorSet: [color1,color2,color3,color4],
///   radius: 150,
///   curve: Curves.easeIn,
///   duration: Duration(seconds: 2),
///   frameThickness: 16,
/// ),
/// ...
///```

/// animated colorfull rign widget that will be `width=height=radius*2`. change colors based on [duration] you provide, default `Duration(milliseconds: 150),` with `Curves.ease`
class NeonRingWidget extends StatefulWidget {
  /// rign radius, use to draw circle[Container],
  final double radius;

  /// ColorSet that will change over time using[changeColorHue]
  final List<Color> colorSet;

  ///Duration of animation default=`Duration(milliseconds: 150),`
  final Duration duration;

  /// default Curve= `Curves.ease`
  final Curve curve;

  ///border width, for null value it will use [RingPath]'s `borderThickness:16px`
  final double? frameThickness;

  const NeonRingWidget({
    Key? key,
    required this.colorSet,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.ease,
    this.frameThickness,
    required this.radius,
  }) : super(key: key);

  @override
  State<NeonRingWidget> createState() => _NeonRingWidgetState();
}

class _NeonRingWidgetState extends State<NeonRingWidget> {
  Timer? _timer;

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
        setState(() {
          colorSet = colorSet
              .map(
                (color) => changeColorHue(
                  color: color,
                  increaseBy: 1,
                ),
              )
              .toList();
        });
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
    return ClipPath(
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
    );
  }
}
