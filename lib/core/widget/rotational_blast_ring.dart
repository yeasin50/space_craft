import 'package:flutter/material.dart';

import '../utils/helpers/angle_conversion.dart';
import '../../feature/on_play/widgets/ship_blast.dart';

class RotationalBlastRing extends StatefulWidget {
  /// define the ring radius that will be used to align the number of blast
  final double radius;

  /// how many blast[] widget to used to create ring within [radius], default 7
  final int numberOfBlast;

  /// bust size for each,Size(x,4x) is perfect shape
  /// default value is `blastSize: Size(22, 22 * 4)`
  final Size? blastSize;

  final Widget? child;
  const RotationalBlastRing({
    Key? key,
    required this.radius,
    this.blastSize = const Size(22, 22 * 4),
    this.numberOfBlast = 7,
    this.child,
  }) : super(key: key);

  @override
  State<RotationalBlastRing> createState() => _RotationalBlastRingState();
}

class _RotationalBlastRingState extends State<RotationalBlastRing> {
  late double ringRadius = widget.radius;

  late final Size blastSize = widget.blastSize!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ringRadius * 2,
      width: ringRadius * 2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ...List.generate(
            widget.numberOfBlast,
            (index) => Transform.rotate(
              alignment: Alignment.center,
              angle: deg2rad(360 / widget.numberOfBlast * index),
              child: Container(
                height: ringRadius * 2,
                width: ringRadius * 2,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: blastSize.width,
                  height: blastSize.height,
                  child: const ShipBlast(
                      // size: blastSize, // no effect
                      ),
                ),
              ),
            ),
          ),
          if (widget.child != null) widget.child!,
        ],
      ),
    );
  }
}
