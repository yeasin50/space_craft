import 'package:flutter/material.dart';

import '../provider/provider.dart';
import 'model.dart';

abstract class GameObject {
  Vector2 get position;
  Size get size;
  Color get color;
}

abstract class IBullet implements GameObject {
  int? get id;
}

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
  Size get size => GObjectSize.instatnce.playerBullet;
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
  Size get size => GObjectSize.instatnce.enemyBullet;
}
