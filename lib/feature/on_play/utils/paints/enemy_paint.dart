import 'package:flutter/material.dart';

///TODO: remove on finish if !necessay 
class EnemyPainter1 extends CustomPainter {
  /// animation value [0..1] of this paint
  /// *hands and legs movement (done know how can I describe this)🤣
  final double value;

  EnemyPainter1({
    required this.value,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // using rect to draw this UI,
    // we can also use GridView,but animation 🤔
    final blocSize = size.width / 12;

    final paint = Paint()..color = Colors.amber;

    Path topPath = Path()
      ..moveTo(blocSize * 2, 0)
      ..lineTo(blocSize * 3, 0)
      ..lineTo(blocSize * 3, blocSize)
      ..lineTo(blocSize * 4, blocSize)
      ..lineTo(blocSize * 5, blocSize * 2) // End of left top tail

      ..lineTo(blocSize * 8, blocSize * 2)
      ..lineTo(blocSize * 8, blocSize)
      ..lineTo(blocSize * 9, blocSize)
      ..lineTo(blocSize * 9, 0)
      ..lineTo(blocSize * 10, 0)
      ..lineTo(blocSize * 11, blocSize)
      ..lineTo(blocSize * 10, blocSize)
      ..lineTo(blocSize * 10, blocSize * 2) // end of top-right two bloc

      ///
      ..close();

    canvas.drawPath(topPath, paint);
    // canvas.drawRect(
    //   Rect.fromPoints(
    //     Offset(blocSize * 2, 0),
    //     Offset(blocSize * 3, blocSize),
    //   ),
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(covariant EnemyPainter1 oldDelegate) =>
      value != oldDelegate.value;
}
