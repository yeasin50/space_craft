import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:space_craft/constants/color_palette.dart';

/// A circular neon Background/frame with little [Animation] of [Colors]
///this is repeated Animation using 4 colors.
class NeonCircle extends StatefulWidget {
  ///Duration of animation default=`Duration(seconds: 2)`
  final Duration duration;

  /// default Curve= `Curves.ease`
  final Curve curve;

  /// Main Widget inside Frame
  final Widget child;

  ///radius of widget
  final double radius;

  ///The Space between child and outter Container/frame known as NeonCircleBackground
  final double frameThickness;

  const NeonCircle(
      {Key? key,
      this.duration = const Duration(seconds: 2),
      this.curve = Curves.ease,
      required this.radius,
      this.frameThickness = 9,
      required this.child})
      : super(key: key);

  @override
  _NeonCircleState createState() => _NeonCircleState();
}

class _NeonCircleState extends State<NeonCircle>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;

  final Random random = Random();

  _initWave() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() => setState(() {}));

    _animation = Tween<double>(begin: 0, end: 270).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void initState() {
    super.initState();
    _initWave();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildChildCircle();
  }

  Stack buildChildCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: _animation.value * pi / 180,
          child: Container(
            height: widget.radius + 9,
            width: widget.radius + 9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: _animation.value < 55
                      ? colorSet1[random.nextInt(colorSet1.length - 1)]
                      : Colors.transparent,
                  spreadRadius: 2,
                ),
              ],
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: _animation.value < 50
                    ? [
                        colorSet1[0],
                        colorSet1[3],
                      ]
                    : colorSet1,
              ),
            ),
          ),
        ),
        ClipOval(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: widget.radius,
              maxWidth: widget.radius,
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
