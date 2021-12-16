import 'package:flutter/material.dart';
import 'package:space_craft/model/model.dart';

abstract class IShip {
  late final Color color;
  late final Size size;

  //ship Health per life
  late final double health;
  late final Vector2 position2d;
}
