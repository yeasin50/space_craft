import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../../../widget/widget.dart';
import '../utils/utils.dart';

Widget playerShip() {
  return Container(
    height: GObjectSize.instatnce.playerShip.height,
    width: GObjectSize.instatnce.playerShip.width,
    color: Colors.red,
  );
}

/// ship widget represent player
class PlayerShip extends StatelessWidget {
  const PlayerShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GObjectSize.instatnce.playerShip.width,
      height: GObjectSize.instatnce.playerShip.height * 1.25,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ShipBlast(
              size: Size(
                GObjectSize.instatnce.playerShip.width * .125,
                GObjectSize.instatnce.playerShip.height * .5,
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              GObjectSize.instatnce.playerShip.width,
              GObjectSize.instatnce.playerShip.height,
            ),
            painter: PlayerShipPaint(),
          ),
        ],
      ),
    );
  }
}
