import 'package:flutter/material.dart';
import 'package:space_craft/core/providers/providers.dart';

import '../../../core/constants/constants.dart';
import '../../../core/package/glitch_effect/glitch_effect.dart';
import '../models/ship.dart';
import '../utils/paints/enemy_ships_paint/enemy_ships_paint.dart';
import '../utils/utils.dart';

class EnemyShipWidget extends StatelessWidget {
  const EnemyShipWidget({
    Key? key,
    required this.ship,
  }) : super(key: key);
  final EnemyShip ship;

  @override
  Widget build(BuildContext context) {
    return ship.state == ShipState.glitch
        ? GlitchEffect(
            controller: GlitchController(autoPlay: true),
            child: const _AnimatedEnemyShipA()
            //  _buildEnemyShip(),
            )
        : const _AnimatedEnemyShipA();
    //  _buildEnemyShip();
  }

  Image _buildEnemyShip() {
    return Image.asset(
      enemyShipImagePath(enemy: ship),
      width: ship.size.width,
      height: ship.size.height,
      color: ship.color,
    );
  }
}

/// Animating enemy Tail, But it is not event noticeable 😐
class _AnimatedEnemyShipA extends StatefulWidget {
  const _AnimatedEnemyShipA({Key? key}) : super(key: key);

  @override
  State<_AnimatedEnemyShipA> createState() => __AnimatedEnemyShipAState();
}

class __AnimatedEnemyShipAState extends State<_AnimatedEnemyShipA>
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
      size: GObjectSize.instance.enemyShip,
      painter: EnemyAPainter(
        tailAnimation: animation,
      ),
    );
  }
}
