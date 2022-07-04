import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ColorManager {
  static final ColorManager instance = ColorManager._privateConstructor();
  ColorManager._privateConstructor();

  Color _background = Colors.black;

  Color playerTopBody = Colors.red;
  Color playerBody = Colors.white;

  List<Color> enemies = [...ColorPallet.enemies];
}
