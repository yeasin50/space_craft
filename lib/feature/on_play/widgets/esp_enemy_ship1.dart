import 'package:flutter/material.dart';

import '../../../core/providers/providers.dart';
import '../utils/paints/paints.dart';

/// Animating enemy Tail, But it is not event noticeable 😐
class AnimatedEnemyShipA extends StatefulWidget {
  final Size? size;
  const AnimatedEnemyShipA({
    Key? key,
    this.size,
  }) : super(key: key);

  @override
  State<AnimatedEnemyShipA> createState() => _AnimatedEnemyShipAState();
}

class _AnimatedEnemyShipAState extends State<AnimatedEnemyShipA>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size ?? GObjectSize.instance.enemyShip,
      painter: EnemyAPainter(
        tailAnimation: animation,
      ),
    );
  }
}
