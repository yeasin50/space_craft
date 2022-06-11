import 'dart:math' as math;

import 'package:flutter/material.dart';

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
  bool showMagicBall = true;
  bool showBlastRing = false;
  bool showNeonCircle = false;

  bool defaultBlastSize = false;
  double numberOfBlast = 5.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        ///* used on [NeonRingWidget]
        final double ringMaxSize = math.min(width, height) * .35;
        final double neonRingSize = ringMaxSize * 1.3;
        final double blastHeight = math.min(width, height) * .05;
        return Stack(
          alignment: Alignment.center,
          children: [
            Align(
              child: AnimatedMagicBall(
                key: const ValueKey("MagicBall-Scaler widget"),
                maxSize: ringMaxSize,
              ),
            ),
            Align(
              child: NeonRingAnimation(
                size: neonRingSize,
              ),
            )
          ],
        );
      },
    );
  }
}
