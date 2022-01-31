import 'dart:math' as _math;

import 'package:flutter/material.dart';

///```
///RotateWidget(
///  curve: Curves.easeIn,
///  duration: const Duration(seconds: 5),
///  repeat: true,
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
  /// listen animation value
  final Function(double value)? onChanged;

  const RotateWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 5),
    this.curve = Curves.ease,
    this.repeat = true,
    this.rotateAxis = const <bool>[false, true, false],
    this.onChanged,
  }) : super(key: key);

  /// rotate this child
  final Widget child;

  /// repeat the animation process [AnimationController.repeat],
  /// `default:true`
  final bool repeat;

  /// use `List<bool>` enable rotation of `[X,Y,Z]` based on bool:true
  /// default value is `[false, true, false]` to rotate on Y axis
  final List<bool> rotateAxis;

  /// duration of single rotate-animation, default 5sec
  final Duration duration;

  /// animation curve , default is [Curves.easeIn]
  final Curve curve;

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
        if (widget.rotateAxis[0]) transformMatrix.rotateX(_animation.value);
        if (widget.rotateAxis[1]) transformMatrix.rotateY(_animation.value);
        if (widget.rotateAxis[2]) transformMatrix.rotateZ(_animation.value);
        setState(() {});

        if (widget.onChanged != null) {
          widget.onChanged!(_animation.value);
        }
      });

    _animation = Tween<double>(begin: 0.0, end: _math.pi * 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: widget.curve),
      ),
    );

    if (widget.repeat) {
      _controller.repeat();
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
