import 'package:flutter/material.dart';

import '../../../core/constants/color_palette.dart';
import '../../../core/widget/widget.dart';

class NeonRingAnimation extends StatefulWidget {
  final double size;
  const NeonRingAnimation({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<NeonRingAnimation> createState() => _NeonRingAnimationState();
}

class _NeonRingAnimationState extends State<NeonRingAnimation> {
  late AnimationController controller;

  late Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: NeonRingWidget(
        colorBlink: true,
        duration: const Duration(milliseconds: 30),
        colorSet: colorSet0,
        size: widget.size,
        frameThickness: widget.size * .5,
      ),
    );
  }
}
