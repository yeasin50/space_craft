import 'package:flutter/material.dart';
import 'package:glitch_effect/glitch_effect.dart';

import '../../../core/constants/constants.dart';
import '../../../core/entities/ship.dart';
import '../models/ship.dart';
import '../utils/utils.dart';
import 'esp_enemy_ship1.dart';

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

  Widget _buildEnemyShip() {
    if (ship.name == ShipName.enemyD) {
      return const AnimatedEnemyShipA();
    }
    return CustomPaint(
      size: Size(ship.size.width, ship.size.height),
      painter: InvaderPaintA(invaderMatrix: getShipMatrix(ship)),
    );
  }
}
