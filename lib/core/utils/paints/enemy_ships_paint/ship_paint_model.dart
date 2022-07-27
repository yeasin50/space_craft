import 'package:flutter/material.dart';

class ShipPaintSetting {
  final Color bodyColor;
  final Color beltColor;

  ShipPaintSetting({
    this.bodyColor = Colors.white,
    this.beltColor = Colors.amber,
  });

  factory ShipPaintSetting.defaultSetting() {
    return ShipPaintSetting();
  }
}
