import 'package:flutter/material.dart';

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
    return Image.asset(
      enemyShipImagePath(enemy: ship),
      width: ship.size.width,
      height: ship.size.height,
      color: ship.color,
    );
  }
}
