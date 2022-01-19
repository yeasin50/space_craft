import 'package:flutter/material.dart';

import '../../../provider/provider.dart';

/// provide player ship healing portion, increase player ship health
class HealingPortionOverlay extends ConsumerWidget {
  const HealingPortionOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthBoxNotifer = ref.watch(healingObjectProvider).healingBoxes;

    return Stack(
      children: [
        ...healthBoxNotifer.map(
          (hb) => Positioned(
            left: hb.position.dX,
            top: hb.position.dY,
            child: Container(
              color: hb.color,
              height: hb.size.height,
              width: hb.size.width,
            ),
          ),
        )
      ],
    );
  }
}
