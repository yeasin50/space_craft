import 'dart:js';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:space_craft/constants/constants.dart';
import 'package:space_craft/utils/angle_conversion.dart';
import 'package:space_craft/widget/widget.dart';

import '../../packages/packages.dart';
import 'start.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

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
              children: [
                //center Start button
                Align(
                  alignment: Alignment.center,
                  child: GloabTransform(
                    radius: ringRadius * 1.2,
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: RorationalBlustRing(
                    radius: ringRadius * 1.1,
                    blutSize: Size(blastHeight * 4, blastHeight),
                    numberOfBlust: 4,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: MagicBall(
                    radius: ringRadius * .7,
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

class GloabTransform extends StatefulWidget {
  final double radius;
  const GloabTransform({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  State<GloabTransform> createState() => _GloabTransformState();
}

class _GloabTransformState extends State<GloabTransform> {
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
