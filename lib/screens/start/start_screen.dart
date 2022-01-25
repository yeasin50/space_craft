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

            //* used on `NeonRingWidget`
            final double ringRadius = math.min(width, height) * .25;
            final double blastHeight = math.min(width, height) * .05;
            return Stack(
              children: [
                /// fire burn 4 corners

                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ShipBlast(
                //     animationDuration: const Duration(milliseconds: 30),
                //     size: Size(blastHeight / 4, blastHeight),
                //   ),
                // ),

                ///center Start button
                // Align(
                //   alignment: Alignment.center,
                //   child: GloabTransform(
                //     radius: rignRadius,
                //   ),
                // ),

                Align(
                  alignment: Alignment.center,
                  child: RorationalBlustRing(
                    radius: ringRadius,
                  ),
                )
                // Align(
                //   alignment: Alignment.center,
                //   child: MagicBall(
                //     radius: rignRadius * .7,
                //   ),
                // )
              ],
            );
          },
        ),
      ),
    );
  }
}

class RorationalBlustRing extends StatefulWidget {
  final double radius;
  const RorationalBlustRing({
    Key? key,
    required this.radius,
  }) : super(key: key);

  @override
  State<RorationalBlustRing> createState() => _RorationalBlustRingState();
}

class _RorationalBlustRingState extends State<RorationalBlustRing> {
  late double rignRadius = widget.radius;

  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: sliderValue,
          min: 0,
          max: 20,
          onChanged: (value) {
            setState(() => sliderValue = value);
          },
        ),
        SizedBox(
          height: rignRadius * 2,
          width: rignRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ///todo: align the widgets
              ...List.generate(
                sliderValue.toInt(),
                (index) => Transform.rotate(
                  angle: deg2rad((360 / sliderValue * index)),
                  child: const ShipBlast(
                    size: Size(22, 22 * 4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
            colorSet: colorSet0,
            radius: rignRadius,
            frameThickness: rignRadius * .5,
          ),
        ),
      ],
    );
  }
}
