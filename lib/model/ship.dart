import 'package:flutter/material.dart';

import '../provider/provider.dart';
import 'model.dart';

abstract class IShip implements GameObject {
  //ship Health per life
  late final IShipHealth health;
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
  Size get size => GObjectSize.instatnce.playerShip;

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = PlayerHealthManager();
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
  Size size =  GObjectSize.instatnce.enemyShip;

  @override
  Color get color => _color;

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = NEnemyHealthManager();
}
