import 'package:flutter/material.dart';

import '../../../core/package/neon_ring/neon_ring.dart';

class NeonRingAnimation extends StatefulWidget {
  final NeonCircleData data;

  const NeonRingAnimation({
    Key? key,
    required this.data,
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
        data: NeonCircleData(
          colorBlink: widget.data.colorBlink,
          duration: const Duration(milliseconds: 30),
          size: widget.data.size,
          frameThickness: widget.data.size * .5,
        ),
      ),
    );
  }
}
