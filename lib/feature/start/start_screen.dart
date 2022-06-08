import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/widget/widget.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool showMagicBall = false;
  bool showBlastRing = false;
  bool showNeonCircle = false;

  bool defaultBlastSize = false;

  double numberOfBlast = 5.0;

  final magicBallKey = GlobalKey();
  final blastKey = GlobalKey();
  final ringKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
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
                    radius: ringRadius * 1.2,
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
                    key: magicBallKey,
                    radius: ringRadius * .7,
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
        ),
      ),
    );
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
  late double ringRadius;

  @override
  void initState() {
    ringRadius = widget.radius;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: NeonRingWidget(
            duration: Duration(milliseconds: 30),
            colorSet: colorSet0,
            radius: ringRadius,
            frameThickness: ringRadius * .5,
          ),
        ),
      ],
    );
  }
}
