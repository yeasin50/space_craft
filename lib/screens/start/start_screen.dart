import 'dart:js';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:space_craft/constants/constants.dart';
import 'package:space_craft/utils/angle_conversion.dart';
import 'package:space_craft/widget/widget.dart';

import '../../packages/packages.dart';
import 'start.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool showMagicBall = false;
  bool showBlustRing = false;
  bool showNeonCircle = false;

  bool defaultBlustSize = false;

  double numberOfBlust = 5.0;

  final magicBallKey = GlobalKey();
  final blustKey = GlobalKey();
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

                if (showBlustRing)
                  RorationalBlustRing(
                    key: ValueKey("$blustKey $defaultBlustSize"),
                    radius: ringRadius * 1.1,
                    blutSize: defaultBlustSize
                        ? null
                        : Size(blastHeight * 4, blastHeight),
                    numberOfBlust: numberOfBlust.toInt(),
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
                          value: showBlustRing,
                          onChanged: (value) =>
                              setState(() => showBlustRing = !showBlustRing),
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
                            value: numberOfBlust,
                            divisions: 20,
                            max: 20,
                            onChanged: (value) {
                              setState(() {
                                numberOfBlust = value;
                              });
                            },
                          ),
                        ),
                        Checkbox(
                          key: ValueKey("bChanger $defaultBlustSize"),
                          value: defaultBlustSize,
                          onChanged: (value) => setState(
                              () => defaultBlustSize = !defaultBlustSize),
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
  late double rignRadius;

  @override
  void initState() {
    rignRadius = widget.radius;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: NeonRignWidget(
            duration: Duration(milliseconds: 30),
            colorSet: colorSet0,
            radius: rignRadius,
            frameThickness: rignRadius * .5,
          ),
        ),
      ],
    );
  }
}
