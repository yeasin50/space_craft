import 'dart:math' as math;

import 'package:flutter/material.dart';

class ColorPallet {
  static const player = Colors.white;
  static const enemyA = Color(0xff001eff);
  static const enemyB = Color(0xff8900ff);
  static const enemyC = Color(0xffff008d);

  static get enemies => [enemyA, enemyB, enemyC];

  static const background = Colors.black;
  static const glassMorphism = Color(0xFF454A4D);
}

List<Color> get _enemyShipColors => [
      ColorPallet.enemyA,
      ColorPallet.enemyB,
      ColorPallet.enemyC,
    ];

// Color get getRandomColor =>
//     _enemyShipColors[math.Random().nextInt(_enemyShipColors.length)];

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

/// 4Colors
const List<Color> colorSet2 = [
  Color.fromARGB(255, 61, 255, 97),
  Color.fromARGB(255, 139, 85, 255),
  Color.fromARGB(255, 232, 255, 59),
  Color.fromARGB(255, 253, 41, 41),
];

List<List<Color>> _colorSets = [
  colorSet0,
  // colorSet0.reversed.toList(),
  colorSet1,
  // colorSet1.reversed.toList(),
  colorSet2
];

List<Color> get getRandomColorSet =>
    _colorSets[math.Random().nextInt(_colorSets.length - 1)];

Color get getRandomColor =>
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
