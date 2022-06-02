import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widget/widget.dart';
import '../../setting/models/object_scalar.dart';
import '../provider/provider.dart';
import '../utils/paints/heart_painter.dart';

 

/// provide player ship healing portion, increase player ship health
class HealingPortionOverlay extends ConsumerWidget {
  const HealingPortionOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthBoxNotifer = ref.watch(healingObjectProvider).healingBoxes;

    return Stack(
      children: [
        ...healthBoxNotifer.map((hb) {
          return AnimatedPositioned(
            key: ValueKey(hb),
            duration: GObjectSize.instance.animationDuration,
            left: hb.position.dX,
            top: hb.position.dY,
            child: RotateWidget(
              //not using animated Value for heavy🤔
              child: CustomPaint(
                size: Size(hb.size.width, hb.size.height),
                painter: HeartPainter.radial(),
              ),
            ),
          );
        })
      ],
    );
  }
}
