import 'package:flutter/material.dart';

import '../../../../../core/entities/entities.dart';

//* based Invader ship is 12x8 bloc
class InvaderPaintA extends CustomPainter {
  final InvaderMatrix invaderMatrix;

  InvaderPaintA({
    required this.invaderMatrix,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Size blocSize = Size(size.width / 12, size.height / 8);

    for (int i = 0; i < invaderMatrix.data.length; i++) {
      for (int j = 0; j < invaderMatrix.data[i].length; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            i * blocSize.width,
            j * blocSize.height,
            //issue https://stackoverflow.com/q/73184281/10157127
            blocSize.width + 1,
            blocSize.height + 1,
          ),
          Paint()..color = InvaderMatrix.blocColor(invaderMatrix.data[i][j]),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant InvaderPaintA oldDelegate) => false;
}
