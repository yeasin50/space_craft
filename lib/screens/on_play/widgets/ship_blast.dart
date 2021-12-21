import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ShipBlast extends StatefulWidget {
  const ShipBlast({Key? key}) : super(key: key);
  final Size size = const Size(100, 400);
  @override
  _ShipBlastState createState() => _ShipBlastState();
}

class _ShipBlastState extends State<ShipBlast>
    with SingleTickerProviderStateMixin {
  late AnimationController _blastController;
  late Animation<double> _animationBlast;

  final Duration _blustDuration = const Duration(milliseconds: 30);
  @override
  void initState() {
    _blastController = AnimationController(
      vsync: this,
      duration: _blustDuration, // controll flow based on GameMode
    )..addListener(() => setState(() {}));

    _animationBlast =
        Tween<double>(begin: .6, end: 1.0).animate(_blastController);
    super.initState();

    _blastController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationBlast,
      alignment: Alignment.topCenter,
      child: CustomPaint(
        size: widget.size,
        painter: ShipBlastPainter(),
      ),
    );
  }
}
