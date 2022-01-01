import 'package:flutter/material.dart';

import 'model.dart';

abstract class IShip implements GameObject {
  //ship Health per life
  late final double health;
}

class Player implements IShip {
  late final Vector2 _position;

  Player({
    required Vector2 position,
  }) {
    _position = position;
  }

  ///max number of time player can live
  final int maxLive = 3;

  /// fire while player is alive and game is runnign
  bool shoot = false;

  @override
  Color color = Colors.deepPurpleAccent;

  @override
  double health = 100.0;

  @override
  Size size = const Size(50, 50);

  @override
  Vector2 get position => _position;
}

class EnemyShip implements IShip {
  late final Vector2 _position;

  EnemyShip({
    required Vector2 position,
  }) {
    _position = position;
  }

  @override
  Size size = const Size(24, 24);

  @override
  Color color = Colors.pink;

  @override
  double health = 5;

  @override
  Vector2 get position => _position;
}
