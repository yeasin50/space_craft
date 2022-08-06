import 'package:flutter/material.dart';

import '../../../../../core/entities/entities.dart';

//* based Invader ship is 12x8 bloc
class InvaderPaintA extends CustomPainter {
  final Matrix8x12 invaderMatrix;

  InvaderPaintA({
    required this.invaderMatrix,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // InvaderMatrix.printData(invaderMatrix);

    Size blocSize = Size(
      size.width / Matrix8x12.col,
      size.height / Matrix8x12.row,
    );
    for (int i = 0; i < Matrix8x12.row; i++) {
      for (int j = 0; j < Matrix8x12.col; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            j * blocSize.width,
            i * blocSize.height,
            //issue https://stackoverflow.com/q/73184281/10157127
            blocSize.width - 2,
            blocSize.height - 2,
          ),
          Paint()..color = Matrix8x12.blocColor(invaderMatrix.data[i][j]),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant InvaderPaintA oldDelegate) => false;
}
