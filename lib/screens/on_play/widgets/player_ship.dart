import 'package:flutter/material.dart';
import '../../../provider/provider.dart';
import '../../../utils/utils.dart';
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

          /// part test

          Consumer(
            builder: (context, ref, child) {
              final player = ref.watch(playerInfoProvider).player;
              return Positioned(
                top: player.bottomPart.position.dY,
                left: player.bottomPart.position.dX,
                child: Container(
                  height: player.bottomPart.size.height,
                  width: player.bottomPart.size.width,
                  color: Color.fromARGB(255, 240, 255, 24).withOpacity(.5),
                ),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final player = ref.watch(playerInfoProvider).player;
              return Positioned(
                top: player.topPart.position.dY,
                left: player.topPart.position.dX,
                child: Container(
                  height: player.topPart.size.height,
                  width: player.topPart.size.width,
                  color: Color.fromARGB(255, 2, 17, 231).withOpacity(.5),
                ),
              );
            },
          ),

          Opacity(
            opacity: .3,
            child: CustomPaint(
              size: Size(
                GObjectSize.instatnce.playerShip.width,
                GObjectSize.instatnce.playerShip.height,
              ),
              painter: PlayerShipPaint(),
            ),
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
                      GObjectSize.instatnce.playerShip.height * .45;
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
