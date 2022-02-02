import 'dart:math' as _math;

import 'package:flutter/material.dart';

///```
///RotateWidget(
///  const Interval(0.0, 0.9, curve: Curves.linear),
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
    this.interval = const Interval(0.0, 1.0, curve: Curves.linear),
    this.repeat = true,
    this.reverseOnRepeat = true,
    this.rotateAxis = const [false, true, false],
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

  List<bool>? axis;

  @override
  void initState() {
    axis = _axisSetup(widget.rotateAxis);
    _animVariableInit();
    super.initState();
  }

  /// axisSetUp defaul value is `[false,true,false]`
  List<bool> _axisSetup(List<bool> widgetRotateAxis) {
    ///* _axis = [false,true,false]
    List<bool> _axis = List.generate(3, (index) => index == 1 ? true : false);
    // feed user data
    for (int i = 0; i < widgetRotateAxis.length && i < _axis.length; i++) {
      _axis[i] = widgetRotateAxis[i];
    }
    return _axis;
  }

  /// init animation data [axis]
  void _animVariableInit() {
    /// todo: handle assert message
    assert(
      axis != null,
      "Got null on axis, init _axisSetup setup on initState",
    );

    final double _maxRotation = _math.pi * 2;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        transformMatrix = Matrix4.identity();
        if (axis![0]) {
          transformMatrix.rotateX(_animation.value);
        }
        if (axis![1]) {
          transformMatrix.rotateY(_animation.value);
        }
        if (axis![2]) {
          transformMatrix.rotateZ(_animation.value);
        }
        setState(() {});

        if (widget.onChanged != null) {
          widget.onChanged!(_animation.value / _maxRotation);
        }
      });

    _animation = Tween<double>(begin: 0.0, end: _maxRotation).animate(
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
