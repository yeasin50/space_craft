import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';
import '../../../widget/widget.dart';
import 'widgets.dart';

/// enemy ships and enemy's bullets on  [_EnemyBulletOverlay] widget
class EnemyOverlay extends ConsumerWidget {
  const EnemyOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enemyNotifer = ref.watch(enemyProvider);
    return Stack(
      key: const ValueKey("Enemies Stack"),
      children: [
        ...enemyNotifer.enemies.map(
          (EnemyShip e) => AnimatedPositioned(
            duration: GObjectSize.instatnce.animationDuration,
            top: e.position.dY,
            left: e.position.dX,
            child: EnemyShipWidget(
              ship: e,
            ),
          ),
        ),

        ...enemyNotifer.bullets.map(
          (b) => AnimatedPositioned(
            duration: GObjectSize.instatnce.animationDuration,
            top: b.position.dY,
            left: b.position.dX,
            child: BulletWidget(
              bulletHeight: b.size.height,
              color: b.color,
            ),
          ),
        ),
        // _EnemyBulletOverlay(bullets: enemyNotifer.bullets),

        /// bullets overlay
        /// todo: blust will be replaced by rive
        /// FIXME:  blust not working
        // ...enemyNotifer.shipsBlustLocation.map(
        //   (blustLoc) => Positioned(
        //     // duration: GObjectSize.instatnce.animationDuration,
        //     top: blustLoc.dY - 20, //minimize the blust size
        //     left: blustLoc.dX - 20,
        //     child: const MagicBall.singleBlust(
        //       radius: 40,
        //     ),
        //   ),
        // )
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
