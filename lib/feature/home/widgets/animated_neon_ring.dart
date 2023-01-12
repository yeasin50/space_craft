import 'package:flutter/material.dart';
import 'package:neon_ring/neon_ring.dart';


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
      child: NeonRingWidget(data: widget.data),
    );
  }
}
