import 'package:flutter/material.dart';

import 'model.dart';

class Bullet {
  Vector2 position;
  final int? id;
  final double radius;

  final Color color;

  Bullet({
    required this.position,
    this.id,
    this.radius = 10,
    this.color = Colors.green,
  });
}
