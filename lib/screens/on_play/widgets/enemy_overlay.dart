import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';
import 'widgets.dart';

class EnemyOverlay extends ConsumerWidget {
  const EnemyOverlay({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemyNotifer = ref.watch(enemyProvider);
    enemyNotifer.initScreen(
      screenSize: Size(constraints.maxWidth, constraints.maxHeight),
    );
    return Stack(
      key: const ValueKey("Enemies Stack"),
      children: [
        ...enemyNotifer.enemies.map(
          (EnemyShip e) => Positioned(
            top: e.position2d.dY,
            left: e.position2d.dX,
            child: EnemyShipWidget(
              ship: e,
            ),
          ),
        ),
        const _EnemyBulletOverlay(),
      ],
    );
  }
}

/// separate context *if needed widget to minimize the pressure
class _EnemyBulletOverlay extends ConsumerWidget {
  const _EnemyBulletOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemyNotifer = ref.watch(enemyProvider);
    return Stack(
      key: const ValueKey("Enemies bullet Stack"),
      children: [
        ...enemyNotifer.bullets.map(
          (b) => Positioned(
            top: b.position.dY,
            left: b.position.dX,
            child: Container(
              height: b.radius,
              width: b.radius,
              decoration: BoxDecoration(
                color: b.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
