import 'package:flutter/material.dart';

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

  static const double bulletWidth = 10.0;

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
  Size get size => const Size(bulletWidth, bulletWidth);
}

class EnemyShipBullet implements IBullet {
  late final Vector2 _position;
  late final Color _color;

  static const double bulletWidth = 5.0;

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
  Size get size => const Size(bulletWidth, bulletWidth);
}
