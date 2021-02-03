import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Player {
  double dx = 0, dy = 0;
  double _x = 0, _y = 0; // temp forOffset
  //player body for custom paint
  double height = 50, width = 50;
  Color color;

  double bulletY = -10;
  Player({this.dx, this.dy, this.color = Colors.red});

  get ship => Rect.fromCenter(
        center: Offset(_x, _y),
        height: height,
        width: width,
      );

  get bulletOffset => Offset(0, bulletY);
}
