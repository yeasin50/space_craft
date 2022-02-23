import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../utils/utils.dart';

Widget playerShip() {
  return Container(
    height: GObjectSize.instatnce.playerShip.height,
    width: GObjectSize.instatnce.playerShip.width,
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
