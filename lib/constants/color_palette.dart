import 'dart:math';

import 'package:flutter/painting.dart';

const color1 = Color(0xff001eff);
const color2 = Color(0xff8900ff);
const color3 = Color(0xffff008d);

List<Color> get _enemyShipColors => [color1, color2, color3];

Color get getRandomColor =>
    _enemyShipColors[Random().nextInt(_enemyShipColors.length)];
