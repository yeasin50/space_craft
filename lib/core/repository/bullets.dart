import 'package:flutter/material.dart';

import '../entities/bullet.dart';
import 'object_scalar.dart';
import 'vector2.dart';

class PlayerShipBullet implements IBullet {
  late final Vector2 _position;

  PlayerShipBullet({
    required Vector2 position,
  }) {
    _position = position;
  }

  @override
  Color get color => Colors.amberAccent;

  @override
  int? get id => null;

  @override
  Vector2 get position => _position;

  @override
  Size get size => GObjectSize.instance.playerBullet;
}

class EnemyShipBullet implements IBullet {
  late final Vector2 _position;
  late final Color _color;

  EnemyShipBullet({
    required Vector2 position,
    Color? color,
  }) {
    _position = position;
    _color = color ?? Colors.deepOrange;
  }

  @override
  Color get color => _color;

  @override
  int? get id => null;

  @override
  Vector2 get position => _position;

  @override
  Size get size => GObjectSize.instance.enemyBullet;
}
