import 'package:flutter/material.dart';

import '../../../../../core/entities/entities.dart';

//* based Invader ship is 12x8 bloc
class InvaderPaintA extends CustomPainter {
  final InvaderDataModel data;

  InvaderPaintA({
    required this.data,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Size blocSize = Size(size.width / 12, size.height / 8);

    for (int i = 0; i < data.bloc.length; i++) {
      for (int j = 0; j < data.bloc[i].length; j++) {
        canvas.drawRect(
          Rect.fromLTWH(
            i * blocSize.width,
            j * blocSize.height,
            blocSize.width + .4,
            blocSize.height + .4,
          ),
          Paint()..color = InvaderDataModel.blocColor(data.bloc[i][j]),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant InvaderPaintA oldDelegate) => false;
}
