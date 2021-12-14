import 'package:flutter/material.dart';

import 'model.dart';

class Bullet {
  final Vector2 position;
  final int? id;
  final double radius;

  final Color color;

  Bullet({
    required this.position,
    this.id,
    this.radius = 10,
    this.color = Colors.green,
  });

  Bullet copyWith({
    Vector2? position,
    int? id,
    double? radius,
  }) {
    return Bullet(
      position: position ?? this.position,
      id: id ?? this.id,
      radius: radius ?? this.radius,
    );
  }
}
