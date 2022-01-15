import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class LiveBar extends StatelessWidget {
  /// resize heart. default size is 48px scale 0.16
  final double scale;

  /// health value [0-1.0]
  final double liveValue;

  /// align the Transform.scale being cheating on [HeartPainter]'s drawing
  final Alignment alignment;

  const LiveBar({
    Key? key,
    this.scale = 0.16,
    this.alignment = Alignment.topLeft,
    required this.liveValue,
  }) : super(key: key);

  final Size paintSize = const Size(300 - 1, 300);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          3,
          (index) => ConstrainedBox(
            constraints: BoxConstraints.tight(
              paintSize * scale,
            ),
            child: SizedBox(
              // * widget.liveValue + paintSize.height - 1, // not using spaces
              width: paintSize.width - 1,
              height: paintSize.height,
              child: CustomPaint(
                size: paintSize,
                painter: HeartPainter(value: 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
