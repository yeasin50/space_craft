import 'package:flutter/material.dart';

import 'model.dart';

abstract class IShip {
  late final Color color;
  late final Size size;

  //ship Health per life
  late final double health;
  late final Vector2 position2d;
}

class Player implements IShip {
  ///max number of time player can live
  final int maxLive = 3;

  /// fire while player is alive and game is runnign
  bool shoot = false;

  @override
  Color color = Colors.deepPurpleAccent;

  @override
  double health = 100.0;

  @override
  Vector2 position2d = Vector2();

  @override
  Size size = const Size(50, 50);
}

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
