import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';
import '../../../widget/widget.dart';
import 'widgets.dart';

/// enemy ships and enemy's bullets on  [_EnemyBulletOverlay] widget
class EnemyOverlay extends StatelessWidget {
  const EnemyOverlay({
    Key? key,
    required this.constraints,
    required this.enemyNotifer,
  }) : super(key: key);

  final BoxConstraints constraints;
  final EnemyChangeNotifier enemyNotifer;

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const ValueKey("Enemies Stack"),
      children: [
        ...enemyNotifer.enemies.map(
          (EnemyShip e) => AnimatedPositioned(
            key: ValueKey(e),
            duration: GObjectSize.instatnce.animationDuration,
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
        ...enemyNotifer.shipsblastLocation.map(
          (blastLoc) => Positioned(
            key: ValueKey(blastLoc),
            top: blastLoc.dY - 20, //minimize the blast size
            left: blastLoc.dX - 20,
            child: const MagicBall.singleBlast(
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
          (b) => AnimatedPositioned(
            key: ValueKey(b),
            duration: GObjectSize.instatnce.animationDuration,
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
