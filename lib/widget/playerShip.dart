import 'package:flutter/material.dart';

import '../model/model.dart';

class PlayerShip extends CustomPainter {
  final Player player;

  PlayerShip(this.player);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round;

    canvas.drawRect(player.ship, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
