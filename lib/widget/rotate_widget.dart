import 'dart:math' as _math;

import 'package:flutter/material.dart';

///```
///RotateWidget(
///  const Interval(0.0, 0.9, curve: Curves.easeIn),
///  duration: const Duration(seconds: 5),
///  repeat: true,
///  reverseOnRepeat: true,
///  rotateAxis: const <bool>[false, true, false],
///  child: Container(
///    height: 100,
///    width: 100,
///    color: Colors.amber,
///  ),
///),
///```
/// Rotate child based on [rotateAxis] that is used on X,Y,Z axis
class RotateWidget extends StatefulWidget {
  /// callback animation value between [0-1]
  final Function(double value)? onChanged;

  const RotateWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 5),
    this.interval = const Interval(0.0, 1.0, curve: Curves.easeIn),
    this.repeat = true,
    this.reverseOnRepeat = true,
    List<bool?>? rotateAxis,
    this.onChanged,
  })  : rotateAxis = rotateAxis ??
            const <bool?>[
              false,
              true,
              false
            ], //todo: create condifition to fill remeaning list[3xbool] is user pass mistakley less or more
        super(key: key);

  /// rotate this child
  final Widget child;

  /// repeat the animation process [AnimationController.repeat],
  /// `default:true`
  final bool repeat;

  /// use `List<bool>` enable rotation of `[X,Y,Z]` based on bool:true
  /// default value is `[false, true, false]` to rotate on Y axis
  final List<bool?> rotateAxis;

  /// duration of single rotate-animation, default 5sec
  final Duration duration;

  /// animation interval , default is [Curves.easeIn]
  final Interval interval;

  final bool reverseOnRepeat;

  @override
  State<RotateWidget> createState() => _RotateWidgetState();
}

class _RotateWidgetState extends State<RotateWidget>
    with SingleTickerProviderStateMixin {
  /// everything has been intialized inside [_animVariableInit]
  late AnimationController _controller;
  late Animation<double> _animation;

  /// used on [Transform]'s
  Matrix4 transformMatrix = Matrix4.identity();

  @override
  void initState() {
    _animVariableInit();
    super.initState();
  }

  /// init animation data
  void _animVariableInit() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        transformMatrix = Matrix4.identity();
        if (widget.rotateAxis[0] ?? false) {
          transformMatrix.rotateX(_animation.value);
        }
        if (widget.rotateAxis[1] != null && widget.rotateAxis[1]!) {
          transformMatrix.rotateY(_animation.value);
        }
        if (widget.rotateAxis[2] != null && widget.rotateAxis[2]!) {
          transformMatrix.rotateZ(_animation.value);
        }
        setState(() {});

        if (widget.onChanged != null) {
          widget.onChanged!(_animation.value / (_math.pi));
        }
      });

    _animation = Tween<double>(begin: 0.0, end: _math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.interval,
      ),
    );

    if (widget.repeat) {
      _controller.repeat(reverse: widget.reverseOnRepeat);
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: transformMatrix,
      child: widget.child,
    );
  }
}
