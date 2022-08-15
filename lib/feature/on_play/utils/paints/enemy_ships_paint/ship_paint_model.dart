import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
 

class ShipPaintSetting {
  final Color bodyColor;
  final Color beltColor;

  final List<Color> tailColor;

  ShipPaintSetting({
    this.bodyColor = Colors.white,
    this.beltColor = Colors.amber,
    List<Color>? tailColor,
  }) : tailColor = tailColor ?? colorSet0;

  factory ShipPaintSetting.defaultSetting() {
    return ShipPaintSetting();
  }
}
