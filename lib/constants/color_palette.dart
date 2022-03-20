import 'dart:math' as math;

import 'package:flutter/material.dart';

class ColorPallet {
  static const player = Colors.white;
  static const enemyA = Color(0xff001eff);
  static const enemyB = Color(0xff8900ff);
  static const enemyC = Color(0xffff008d);
}

List<Color> get _enemyShipColors => [
      ColorPallet.enemyA,
      ColorPallet.enemyB,
      ColorPallet.enemyC,
    ];

Color get getRandomColor =>
    _enemyShipColors[math.Random().nextInt(_enemyShipColors.length)];

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

const List<List<Color>> _colorSets = [colorSet0, colorSet1];

List<Color> get getRandomColorSet =>
    _colorSets[math.Random().nextInt(_colorSets.length - 1)];
