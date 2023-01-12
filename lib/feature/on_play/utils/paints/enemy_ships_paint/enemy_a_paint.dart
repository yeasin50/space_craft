import 'dart:core';

import 'package:flutter/material.dart';
import 'package:magic_ball/magic_ball.dart';

import 'enemy_a_tail_paint.dart';
import 'ship_paint_model.dart';

class EnemyAPainter extends CustomPainter {
  final ShipPaintSetting _shipPaintSetting;

  /// enemy tail will shift left and right
  Animation? tailAnimation;

  EnemyAPainter({
    ShipPaintSetting? shipPaintSetting,
    this.tailAnimation,
  }) : _shipPaintSetting =
            shipPaintSetting ?? ShipPaintSetting.defaultSetting();

  //todo: separate and provide diff color and animation

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    //top part
    final double headHeight = height * .4;
    final double beltHeight = height * .3;

    final rect = Rect.fromLTWH(0, headHeight, width, beltHeight);
    final cornerRadius = Radius.circular(width * .2);

    final Path headPath = Path()
      ..fillType = PathFillType.nonZero
      ..moveTo(0, headHeight)
      ..cubicTo(
        width * .1,
        -headHeight * .3,
        width * .9,
        -headHeight * .3,
        width,
        headHeight,
      )
      ..lineTo(0, headHeight)
      ..addRRect(
        RRect.fromRectAndCorners(rect,
            bottomLeft: cornerRadius, bottomRight: cornerRadius),
      )

      ///* horn
      ..moveTo(width * .1, height * .1)
      ..addRect(
        Rect.fromLTRB(
          width * .1,
          height * .1,
          width * .9,
          headHeight,
        ),
      )
      ..close();

    double eyeSize = width * .055;

    final eyesPath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(width * .3, height * .3),
          radius: eyeSize,
        ),
      )
      ..addPath(
        StarPathClipper().getClip(
          Size.fromRadius(eyeSize * 1.12),
        ),
        Offset(width * .65, height * .24),
      );

    final double mouthSize = height * .05;

    Path mouthPath = Path();

    double mouthStartPoint = width * .4;
    double mouthEndPoint = width * .55;

    for (double i = mouthStartPoint; i < mouthEndPoint; i += (mouthSize * .4)) {
      mouthPath.addPath(
        ParticlePathClipper().getClip(Size.fromRadius(mouthSize)),
        Offset(i, height * .44),
      );
    }

    final p = Path.combine(
      PathOperation.xor,
      headPath,
      Path.combine(PathOperation.union, eyesPath, mouthPath),
    );

    final headPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          _shipPaintSetting.bodyColor,
          _shipPaintSetting.beltColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    canvas.drawPath(p, headPaint);

    final tailSize = Size(width, height - headHeight - beltHeight);

    final tailPath = Path()
      ..addPath(
        EnemyTailClipPath(
          shiftValue: tailAnimation?.value,
        ).getClip(tailSize),
        Offset(0, headHeight + beltHeight),
      );

    canvas.drawPath(
      tailPath,
      Paint()
        ..shader = LinearGradient(
          colors: _shipPaintSetting.tailColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.mirror,
        ).createShader(
          Rect.fromLTWH(0, headHeight + beltHeight, width, tailSize.height),
        ),
    );
  }

  @override
  bool shouldRepaint(covariant EnemyAPainter oldDelegate) => true;
}
