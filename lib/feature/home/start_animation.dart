import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/package/neon_ring/neon_ring.dart';
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
  bool defaultBlastSize = false;

  bool enableColorBlink = true;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        ///* used on [NeonRingWidget]
        final double ringMaxSize = math.min(width, height) * .35;
        double neonRingSize = ringMaxSize * 1.3;
        final double blastHeight = math.min(width, height) * .05;
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              key: const ValueKey("MagicBall-Scaler widget"),
              child: AnimatedMagicBall(
                maxSize: ringMaxSize,
                callback: (AnimationController? controller) {},
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
            )
          ],
        );
      },
    );
  }
}
