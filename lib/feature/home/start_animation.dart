import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/widget/widget.dart';

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

  final blastKey = GlobalKey();
  final ringKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        ///* used on [NeonRingWidget]
        final double ringRadius = math.min(width, height) * .35;
        final double blastHeight = math.min(width, height) * .05;
        return Stack(
          alignment: Alignment.center,
          children: [
            //center Start button
            if (showNeonCircle)
              GlobeTransform(
                key: ringKey,
                radius: ringRadius * 2.2,
              ),

            if (showBlastRing)
              RotationalBlastRing(
                key: ValueKey("$blastKey $defaultBlastSize"),
                radius: ringRadius * 1.1,
                blastSize: defaultBlastSize
                    ? null
                    : Size(blastHeight * 4, blastHeight),
                numberOfBlast: numberOfBlast.toInt(),
              ),

            if (showMagicBall)
              MagicBall(
                key: UniqueKey(),
                size: ringRadius * 1.1,
              ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.cyanAccent,
                height: 48,
                child: Row(
                  children: [
                    Checkbox(
                      value: showBlastRing,
                      onChanged: (value) =>
                          setState(() => showBlastRing = !showBlastRing),
                    ),
                    Checkbox(
                      value: showNeonCircle,
                      onChanged: (value) =>
                          setState(() => showNeonCircle = !showNeonCircle),
                    ),
                    Checkbox(
                      value: showMagicBall,
                      onChanged: (value) =>
                          setState(() => showMagicBall = !showMagicBall),
                    ),
                    Expanded(
                      child: Slider(
                        value: numberOfBlast,
                        divisions: 20,
                        max: 20,
                        onChanged: (value) {
                          setState(() {
                            numberOfBlast = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class MagicBalScaler extends StatefulWidget {
  final double maxRadius;

  const MagicBalScaler({
    Key? key,
    required this.maxRadius,
  }) : super(key: key);

  @override
  State<MagicBalScaler> createState() => _MagicBalScalerState();
}

class _MagicBalScalerState extends State<MagicBalScaler>
    with SingleTickerProviderStateMixin {
  final magicBallKey = GlobalKey();
  AnimationController? radiusController;

  Animation<double>? ringRadius;

  @override
  void initState() {
    super.initState();

    radiusController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          });

    ringRadius = Tween<double>(begin: 0, end: 1).animate(radiusController!);
    radiusController?.forward();
  }

  @override
  void dispose() {
    radiusController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Transform.scale(
        //     scale: ringRadius?.value, child: Container(color: Colors.green)
        MagicBall(
      key: UniqueKey(),
      size: ringRadius?.value ?? widget.maxRadius,
    );
    // )
    ;
  }
}

class GlobeTransform extends StatefulWidget {
  final double radius;
  const GlobeTransform({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  State<GlobeTransform> createState() => _GlobeTransformState();
}

class _GlobeTransformState extends State<GlobeTransform> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: NeonRingWidget(
        duration: const Duration(milliseconds: 30),
        colorSet: colorSet0,
        radius: widget.radius,
        frameThickness: widget.radius * .5,
      ),
    );
  }
}
