import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
import '../../../widget/widget.dart';
import '../utils/utils.dart';

Widget playerShip() {
  return Container(
    height: GObjectSize.instance.playerShip.height,
    width: GObjectSize.instance.playerShip.width,
    color: Colors.red,
  );
}

/// ship widget represent player
class PlayerShip extends StatelessWidget {
  const PlayerShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: GObjectSize.instance.playerShip.width,
      height: GObjectSize.instance.playerShip.height * 1.25,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ShipBlast(
              size: Size(
                GObjectSize.instance.playerShip.width * .125,
                GObjectSize.instance.playerShip.height * .5,
              ),
            ),
          ),
          CustomPaint(
            size: Size(
              GObjectSize.instance.playerShip.width,
              GObjectSize.instance.playerShip.height,
            ),
            painter: PlayerShipPaint(),
          ),
          Align(
            alignment: const Alignment(0, -.1),
            child: RotateWidget(
              reverseOnRepeat: false,
              rotateAxis: const [false, false, true],
              // duration: Duration(milliseconds: 200),
              child: ClipPath(
                clipper: StarPathClipper(),
                child: () {
                  final double startSize =
                      GObjectSize.instance.playerShip.height * .45;
                  return Container(
                    height: startSize,
                    width: startSize,
                    color: Colors.amber,
                  );
                }(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}