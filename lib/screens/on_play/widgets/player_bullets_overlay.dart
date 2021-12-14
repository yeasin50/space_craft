import 'package:flutter/material.dart';

import '../../../provider/provider.dart';

class PlayerBulletsOverlay extends ConsumerWidget {
  const PlayerBulletsOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bullets = ref.watch(bulletsProvider).bullets;

    return Stack(
      children: bullets
          .map(
            (b) => Positioned(
              top: b.position.dY,
              left: b.position.dX,
              child: Container(
                width: b.radius,
                height: b.radius,
                color: b.color,
              ),
            ),
          )
          .toList(),
    );
  }
}
