part of color_helper;

/// return new [color] hue change by [increaseBy]
Color changeColorHue({
  required Color color,
  required double increaseBy,
}) {
  HSLColor hslColor = HSLColor.fromColor(color);
  final newHueValue = (increaseBy + hslColor.hue);

  return hslColor
      .withHue(
        newHueValue % 360 < 0 ? newHueValue : newHueValue % 360,
      )
      .toColor();
}
