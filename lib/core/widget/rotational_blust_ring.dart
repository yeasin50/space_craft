import 'package:flutter/material.dart';

import '../utils/helpers/angle_conversion.dart';
import '../../feature/on_play/widgets/ship_blast.dart';

//FIXME: change name
class RorationalBlustRing extends StatefulWidget {
  /// define the ring radius that will be used to align the number of blast
  final double radius;

  /// how many blust[] widget to used to create ring within [radius], deefault 7
  final int numberOfBlust;

  /// bust size for each,Size(x,4x) is perfect shape
  /// default value is `blutSize: Size(22, 22 * 4)`
  final Size? blutSize;

  final Widget? child;
  const RorationalBlustRing({
    Key? key,
    required this.radius,
    this.blutSize = const Size(22, 22 * 4),
    this.numberOfBlust = 7,
    this.child,
  }) : super(key: key);

  @override
  State<RorationalBlustRing> createState() => _RorationalBlustRingState();
}

class _RorationalBlustRingState extends State<RorationalBlustRing> {
  late double rignRadius = widget.radius;

  late final Size blutSize = widget.blutSize!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: rignRadius * 2,
      width: rignRadius * 2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ...List.generate(
            widget.numberOfBlust,
            (index) => Transform.rotate(
              alignment: Alignment.center,
              angle: deg2rad(360 / widget.numberOfBlust * index),
              child: Container(
                height: rignRadius * 2,
                width: rignRadius * 2,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: blutSize.width,
                  height: blutSize.height,
                  child: const ShipBlast(
                      // size: blutSize, // no effect
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
