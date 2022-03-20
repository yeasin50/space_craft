import 'package:flutter/material.dart';

import 'package:space_craft/widget/widget.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';
import 'widgets.dart';

/// enemy ships and enemy's bullets on  [_EnemyBulletOverlay] widget
class EnemyOverlay extends ConsumerWidget {
  const EnemyOverlay({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemyNotifer = ref.watch(enemyProvider);

    return Stack(
      key: const ValueKey("Enemies Stack"),
      children: [
        ...enemyNotifer.enemies.map(
          (IShip e) => Positioned(
            top: e.position.dY,
            left: e.position.dX,
            child: EnemyShipWidget(
              ship: e,
            ),
          ),
        ),
        _EnemyBulletOverlay(bullets: enemyNotifer.bullets),

        /// bullets overlay
        /// todo: add controller
        ...enemyNotifer.shipsBlustLocation.map(
          (blustLoc) => Positioned(
            top: blustLoc.dY - 20, //minimize the blust size
            left: blustLoc.dX - 20,
            child: const MagicBall.singleBlust(
              radius: 40,
            ),
          ),
        )
      ],
    );
  }
}

/// separate context *if needed widget to minimize the pressure
/// maybe merge on parent
class _EnemyBulletOverlay extends StatelessWidget {
  /// enemy bullets passed from parent
  final List<IBullet> bullets;

  const _EnemyBulletOverlay({
    Key? key,
    required this.bullets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const ValueKey("Enemies bullet Stack"),
      children: [
        ...bullets.map(
          (b) => Positioned(
            top: b.position.dY,
            left: b.position.dX,
            child: BulletWidget(
              bulletHeight: b.size.height,
              color: b.color,
            ),
          ),
        ),
      ],
    );
  }
}
