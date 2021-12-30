import 'package:flutter/material.dart';

import 'model.dart';

abstract class IBullet {
  Vector2 get position;
  int? get id;
  double get radius;
  Color get color;
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
  double get radius => 10.0;
}

class EnemyShipBullet implements IBullet {
  late final Vector2 _position;

  EnemyShipBullet({
    required Vector2 position,
  }) {
    _position = position;
  }

  @override
  Color get color => Colors.deepOrange;

  @override
  int? get id => null;

  @override
  Vector2 get position => _position;

  @override
  double get radius => 5.0;
}

//old model
// class BulletX {
//   Vector2 position;
//   final int? id;
//   final double radius;

//   final Color color;

//   BulletX({
//     required this.position,
//     this.id,
//     this.radius = 10,
//     this.color = Colors.green,
//   });
// }
