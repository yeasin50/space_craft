import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/neon_circle_data.dart';
import '../utils/hue_changer.dart';
import 'ring_path.dart';

///```
///This is an example with default value
///....
/// NeonRingWidget(
///  key: UniqueKey(),
///  data: NeonCircleData(size: x),
/// ),
/// ...
///```
/// animated colorful ring widget that will be `size`. change colors based on [duration] you provide, default `Duration(milliseconds: 150),` with `Curves.ease`
class NeonRingWidget extends StatefulWidget {
  final NeonCircleData data;

  const NeonRingWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<NeonRingWidget> createState() => _NeonRingWidgetState();
}

class _NeonRingWidgetState extends State<NeonRingWidget> {
  late final NeonCircleData data = widget.data;

  Timer? _timer;

  double rotateAngel = 0;

  late List<Color> colorSet;

  @override
  void initState() {
    super.initState();
    _initColorTransformation();
  }

  double deg2rad(double deg) => deg * math.pi / 180;

  void _initColorTransformation() {
    colorSet =
        widget.data.colors; // for 1st build, `.toList()` to create new one

    _timer = Timer.periodic(
      widget.data.duration,
      (timer) {
        colorSet = colorSet
            .map(
              (color) => changeColorHue(
                color: color,
                increaseBy: 1,
              ),
            )
            .toList();

        if (widget.data.rotatable) {
          rotateAngel += deg2rad(data.rotationIncrementRateByDegree);
        }
        setState(() {});
      },
    );
  }

  final math.Random random = math.Random();

  List<Color> colorSetModification() {
    if (!data.colorBlink) return colorSet;
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
        clipper: RingPath(
          borderThickness: data.frameThickness,
        ),
        child: Padding(
          padding: data.padding,
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
            width: data.size,
            height: data.size,
            child: data.child,
          ),
        ),
      ),
    );
  }
}
