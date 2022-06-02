import 'package:flutter/material.dart';

import '../../../core/utils/helpers/angle_conversion.dart';
import '../utils/paints/bullet_paint.dart';


class BulletWidget extends StatelessWidget {
  ///bullet `Size(bulletHeight,bulletHeight*4)`
  final double bulletHeight;

  /// bullet color comes from ship color
  final Color color;

  /// Bullet move top to bottom,
  /// - default is `true`
  /// - downward = true for enemyShip
  /// - downward = false for playerShip
  final bool downward;

  const BulletWidget({
    Key? key,
    required this.bulletHeight,
    required this.color,
    this.downward = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomPaint bulletPaint = CustomPaint(
      size: Size(
        bulletHeight,
        bulletHeight * 4,
      ),
      painter: BulletPaint(
        color: color,
      ),
    );

    return downward
        ? bulletPaint
        : Transform.rotate(
            angle: deg2rad(180),
            child: bulletPaint,
          );
  }
}
