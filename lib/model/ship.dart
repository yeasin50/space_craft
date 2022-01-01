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
  Color get color => Colors.deepPurpleAccent;

  @override
  double health = 100.0;

  @override
  Size get size => const Size(50, 50);

  @override
  Vector2 get position => _position;
}

class EnemyShip implements IShip {
  late final Vector2 _position;
  late final Color _color;

  EnemyShip({
    required Vector2 position,
    Color color = Colors.pink,
  }) {
    _position = position;
    _color = color;
  }

  @override
  Size size = const Size(24, 24);

  @override
  Color get color => _color;

  @override
  double health = 5.0;

  @override
  Vector2 get position => _position;
}
