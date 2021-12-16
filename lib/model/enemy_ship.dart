import 'package:flutter/material.dart';

import 'model.dart';

class EnemyShip implements IShip {
  EnemyShip({
    required this.position2d,
  });

  @override
  Size size = const Size(24, 24);

  @override
  Color color = Colors.pink;

  @override
  double health = 5;

  @override
  Vector2 position2d;
}
