import 'package:flutter/material.dart';
import 'package:space_craft/core/widget/magic_ball.dart';

class AnimatedMagicBall extends StatefulWidget {
  final double maxSize;

  const AnimatedMagicBall({
    Key? key,
    required this.maxSize,
  }) : super(key: key);

  @override
  State<AnimatedMagicBall> createState() => _AnimatedMagicBallState();
}

class _AnimatedMagicBallState extends State<AnimatedMagicBall>
    with SingleTickerProviderStateMixin {
  AnimationController? radiusController;
  Animation<double>? ringAnimation;

  @override
  void initState() {
    super.initState();

    radiusController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() => setState(() {}));

    ringAnimation = Tween<double>(begin: 0, end: 1).animate(radiusController!);
    radiusController!.forward();
  }

  @override
  void dispose() {
    radiusController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: ringAnimation?.value,
      child: MagicBall(
        key: const ValueKey("MagicBall widget key"),
        size: widget.maxSize,
      ),
    );
  }
}
