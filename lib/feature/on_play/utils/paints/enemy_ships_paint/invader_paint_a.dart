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
    // InvaderMatrix.printData(invaderMatrix);

    Size blocSize = Size(
      size.width / InvaderMatrix.col,
      size.height / InvaderMatrix.row,
    );
    for (int i = 0; i < InvaderMatrix.row; i++) {
      for (int j = 0; j < InvaderMatrix.col; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            j * blocSize.width,
            i * blocSize.height,
            //issue https://stackoverflow.com/q/73184281/10157127
            blocSize.width - 2,
            blocSize.height - 2,
          ),
          Paint()..color = InvaderMatrix.blocColor(invaderMatrix.data[i][j]),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant InvaderPaintA oldDelegate) => false;
}
