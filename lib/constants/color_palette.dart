import 'dart:math';

import 'package:flutter/material.dart';

const color1 = Color(0xff001eff);
const color2 = Color(0xff8900ff);
const color3 = Color(0xffff008d);

List<Color> get _enemyShipColors => [color1, color2, color3];

Color get getRandomColor =>
    _enemyShipColors[Random().nextInt(_enemyShipColors.length)];

/// Color [purple,blue,yellow,red]
const List<Color> colorSet0 = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

/// 4Colors
const List<Color> colorSet1 = [
  Color.fromRGBO(175, 61, 255, 1),
  Color.fromRGBO(85, 255, 225, 1),
  Color.fromRGBO(255, 59, 148, 1),
  Color.fromRGBO(166, 253, 41, 1),
];
