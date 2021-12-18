import 'package:flutter/material.dart';

import '../../../provider/provider.dart';

class EnemyOverlay extends ConsumerWidget {
  const EnemyOverlay({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemyNotifer = ref.watch(enemyProvider);
    // enemyNotifer.initScreen(
    //   screenSize: Size(constraints.maxWidth, constraints.maxHeight),
    // );
    return Stack(
      children: [
        ...enemyNotifer.enemies.map(
          (e) => Positioned(
            top: e.position2d.dY,
            left: e.position2d.dX,
            child: const Text("E"),
          ),
        ),
      ],
    );
  }
}
