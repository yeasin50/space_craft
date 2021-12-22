import 'package:flutter/material.dart';

import '../utils/utils.dart';

Widget playerShip() {
  return Container(
    height: 50,
    width: 50,
    color: Colors.red,
  );
}

class PlayerShip extends StatefulWidget {
  const PlayerShip({Key? key}) : super(key: key);

  @override
  _PlayerShipState createState() => _PlayerShipState();
}

class _PlayerShipState extends State<PlayerShip> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 400),
      painter: PlayerShipPaint(),
    );
  }
}
