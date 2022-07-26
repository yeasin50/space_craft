import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/package/glitch_effect/glitch_effect.dart';
import '../models/ship.dart';
import '../utils/utils.dart';

class EnemyShipWidget extends StatelessWidget {
  const EnemyShipWidget({
    Key? key,
    required this.ship,
  }) : super(key: key);
  final EnemyShip ship;

  @override
  Widget build(BuildContext context) {
    return ship.state == ShipState.glitch
        ? GlitchEffect(
            controller: GlitchController(autoPlay: true),
            child: _buildEnemyShip(),
          )
        : _buildEnemyShip();
  }

  Image _buildEnemyShip() {
    return Image.asset(
      enemyShipImagePath(enemy: ship),
      width: ship.size.width,
      height: ship.size.height,
      color: ship.color,
    );
  }
}
