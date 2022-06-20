import 'package:flutter/material.dart';

import '../../core/package/neon_ring/neon_ring.dart';
import '../on_play/on_play.dart';
import '../../core/widget/player_ship.dart';
import '../../core/providers/object_scalar.dart';
import 'widgets/animated_neon_ring.dart';
import 'widgets/widgets.dart';

class StartAnimation extends StatefulWidget {
  const StartAnimation({
    Key? key,
    this.onAnimationEnd,
  }) : super(key: key);

  final VoidCallback? onAnimationEnd;

  @override
  State<StartAnimation> createState() => _StartAnimationState();
}

class _StartAnimationState extends State<StartAnimation> {
  bool isCircleAnimating = true;

  static const Duration animationDuration = Duration(seconds: 1);
  @override
  Widget build(BuildContext context) {
    double ringMaxSize = GObjectSize.instance.minLength * .35;
    double neonRingSize = ringMaxSize * 1.3;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          key: const ValueKey("MagicBall-Scaler widget"),
          child: AnimatedMagicBall(
            maxSize: ringMaxSize,
            onEnd: (AnimationController? controller) {
              if (controller == null) return;
              if (controller.status == AnimationStatus.completed) {
                setState(() {
                  isCircleAnimating = false;
                });
              }
            },
          ),
        ),
        Align(
          // colorBlink passed to work update ui properly, having issue on widget tree
          key: const ValueKey("NeonRingAnimation widget"),
          child: NeonRingAnimation(
            data: NeonCircleData(
              size: neonRingSize,
            ),
          ),
        ),
        AnimatedAlign(
          onEnd: () {
            if (widget.onAnimationEnd != null) widget.onAnimationEnd!();
          },
          alignment:
              isCircleAnimating ? const Alignment(0, 1.4) : Alignment.center,
          duration: animationDuration,
          child: const PlayerShip(),
        )
      ],
    );
  }
}
