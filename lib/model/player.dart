import 'package:flutter/material.dart';

import 'model.dart';

class Player implements IShip {
  ///current score of Player
  int score = 0;

  ///max number of time player can live
  final int maxLive = 3;

  /// fire while player is alive and game is runnign
  bool shoot = false;

  @override
  Color color = Colors.deepPurpleAccent;

  @override
  double health = 100.0;

  @override
  Vector2 position2d = Vector2();

  @override
  Size size = const Size(50, 50);
}
