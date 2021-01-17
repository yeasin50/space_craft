import 'package:flutter/cupertino.dart';

class Player {
  double dx = 0, dy = 0;
  double x = 0, y = 0;
  double height = 50, width = 50;

  double bulletY = -10;
  Player({this.dx, this.dy});

  get ship => Rect.fromCenter(
        center: Offset(x, y),
        height: height,
        width: width,
      );

  get bulletOffset => Offset(0, bulletY);
}
