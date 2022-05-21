import 'package:flutter/material.dart';

import '../../../domain/src/entities/game_object.dart';
import 'vector2.dart';
// hiding my sins

class PlayerShipBodyPart implements GameObject {
  final Vector2 _position;
  final Size _size;

  PlayerShipBodyPart({
    required Vector2 position,
    required Size size,
  })  : _position = position,
        _size = size;

  @override
  // no need for this
  Color get color => Colors.cyanAccent;

  @override
  Vector2 get position => _position;

  @override
  Size get size => _size;
}
