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

  final Size paintSize = const Size(300, 300);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: Row(
        children: [
          ...List.generate(
            3,
            (index) => Transform(
              alignment: alignment,
              transform: Matrix4(
                  1, //scale X
                  0,
                  0,
                  0, //eof 1
                  0,
                  1,
                  0, //scale Y
                  0, //eof 2
                  0,
                  0,
                  1,
                  0, //eof 3
                  0,
                  0,
                  0,
                  10 * scale //scale X
                  ),
              child: SizedBox(
                // color: Colors.cyanAccent.withOpacity(.3),
                width: paintSize.width,
                // * widget.liveValue + paintSize.height - 1, // not using spaces
                height: paintSize.height,
                child: CustomPaint(
                  painter: HeartPainter(value: liveValue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
