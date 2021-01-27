import 'package:flutter/material.dart';

class BVector {
  double x, y;
  BVector(this.x, this.y);
}

class Bullet {
  BVector position = BVector(0.0, 0.0);
  // BVector velocity = BVector(0, 0);
  int id;
  double mass = 10.0; //Kg
  double radius = 10 / 100; // 1m = 100 pt or px
  // double area = 0.0314; //PI x R x R;
  // double jumpFactor = -0.6;
  Color color = Colors.green;

  Bullet({this.id, this.position, this.radius});
}
