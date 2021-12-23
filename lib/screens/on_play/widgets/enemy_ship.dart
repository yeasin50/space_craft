import 'package:flutter/material.dart';

import '../../../model/model.dart';

class EnemyShipWidget extends StatelessWidget {
  const EnemyShipWidget({
    Key? key,
    required this.ship,
  }) : super(key: key);
  final EnemyShip ship;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ship.size.height,
      width: ship.size.width,
      color: ship.color,
    );
  }
}
