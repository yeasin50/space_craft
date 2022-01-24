import 'package:flutter/material.dart';

import '../utils/utils.dart';

///```
/// ShipBlast(
/// animationDuration: Duration(milliseconds: 30),
/// size: Size(100, 400),
///),
///```

/// engine fire animation with default `size:const Size(100, 400)`, maintain `Size(x,4x)` to have good effect.
/// It is using [ShipBlastPainter] to draw with [ScaleTransition]
class ShipBlast extends StatefulWidget {
  ///size of engine fire size(x,4x) is perfect shape
  final Size size;

  ///scale transation rate. default speed `Duration(milliseconds: 30)`
  final Duration animationDuration;

  const ShipBlast({
    Key? key,
    this.size = const Size(100, 400),
    this.animationDuration = const Duration(milliseconds: 30),
  }) : super(key: key);

  @override
  _ShipBlastState createState() => _ShipBlastState();
}

class _ShipBlastState extends State<ShipBlast>
    with SingleTickerProviderStateMixin {
  late AnimationController _blastController;
  late Animation<double> _animationBlast;

  late final Duration _blustDuration;
  @override
  void initState() {
    _blustDuration = widget.animationDuration;

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
