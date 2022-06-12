import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../utils/clip_paths/ring_path.dart';
import '../utils/helpers/angle_conversion.dart';
import '../utils/helpers/hue_changer.dart';

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

/// animated colorful ring widget that will be `width=height=radius*2`. change colors based on [duration] you provide, default `Duration(milliseconds: 150),` with `Curves.ease`
class NeonRingWidget extends StatefulWidget {
  /// ring size, use to draw circle[Container],
  final double size;

  /// ColorSet that will change over time using[changeColorHue]
  final List<Color> colorSet;

  ///Duration of animation default=`Duration(milliseconds: 150),` prefer 50 millisecond
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

  final Widget? child;

  final bool colorBlink;

  const NeonRingWidget({
    Key? key,
    required this.colorSet,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.ease,
    this.frameThickness,
    required this.size,
    this.rotation = true,
    this.rotationIncrementRate = 5.0,
    this.child,
    this.colorBlink = true,
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

  final math.Random random = math.Random();

  List<Color> colorSetModification() {
    if (!widget.colorBlink) return colorSet;
    int transparentIndex = random.nextInt(colorSet.length);

    List<Color> newList = colorSet.toList();
    newList[transparentIndex] = Colors.transparent;

    return newList;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            //todo:add blur, replace with shape decorator
            decoration:

                //  ShapeDecoration(
                //   shape: CircleBorder(),
                //   color: Colors.green,
                // ),

                BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: colorSetModification(),
                    ),
                    //create transparent effect on single color
                    boxShadow: colorSetModification()
                        .map(
                          (c) => BoxShadow(
                            color: c.withOpacity(.1),
                            offset: const Offset(3, -6),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        )
                        .toList()),
            width: widget.size,
            height: widget.size,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
