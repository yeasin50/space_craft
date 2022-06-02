import 'package:flutter/painting.dart';

/// return new [color] hue change by [increaseBy]
Color changeColorHue({
  required Color color,
  required double increaseBy,
}) {
  HSLColor hslColor = HSLColor.fromColor(color);
  final _newHueValue = (increaseBy + hslColor.hue);

  return hslColor
      .withHue(
        _newHueValue % 360 < 0 ? _newHueValue : _newHueValue % 360,
      )
      .toColor();
}
