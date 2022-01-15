import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class LiveBar extends StatelessWidget {
  /// resize heart. default size is 48px scale 0.16
  final double scale;

  /// player health value  [0...], divie heart drawing by 100
  final double playerHealth;

  /// align the Transform.scale being cheating on [HeartPainter]'s drawing
  final Alignment alignment;

  const LiveBar({
    Key? key,
    this.scale = 0.16,
    this.alignment = Alignment.topLeft,
    required this.playerHealth,
  }) : super(key: key);

  final Size paintSize = const Size(300 - 1, 300);

  @override
  Widget build(BuildContext context) {
    final int numberOfHeart =
        playerHealth ~/ 100 + (playerHealth % 100 != 0 ? 1 : 0);
    return Row(
      children: [
        ...List.generate(
          numberOfHeart,
          (index) => ConstrainedBox(
            constraints: BoxConstraints.tight(
              paintSize * scale,
            ),
            child: SizedBox(
              // * widget.liveValue + paintSize.height - 1, // not using spaces
              width: paintSize.width,
              height: paintSize.height,
              child: CustomPaint(
                size: paintSize,
                painter: HeartPainter(
                  ///todo: performCalculation
                  value:1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
