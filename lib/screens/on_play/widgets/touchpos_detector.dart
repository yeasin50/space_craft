import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';

//this widget gonna handle UI Touch Position
class TouchPositionDetector extends StatelessWidget {
  const TouchPositionDetector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final playerInfo = watch.read(playerInfoProvider);
        return LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            onPanDown: (details) {
              playerInfo.startShooting();
            },
            onTapUp: (details) {
              // handle quick tap up
              playerInfo.stopShooting();
            },
            onPanEnd: (details) {
              //halde drag tapUp
              playerInfo.stopShooting();
            },
            onPanUpdate: (details) {
              /// touch possition
              var posX = details.localPosition.dx;
              var posY = details.localPosition.dy;

              /// we are separating in two section, it'll help to move though another axis stuck
              /// it'll make sure that even One axis will work even other axis stuc
              if (posY >=
                      constraints.maxHeight - playerInfo.player.height / 2 ||
                  posY <= playerInfo.player.height / 2) {
                ///`we cant move in Y axix` outScreen
                ///may Add some effect like wave
              } else {
                playerInfo
                    .updateTopPosition(posY - (playerInfo.player.height / 2));
              }
              if (posX >= constraints.maxWidth - playerInfo.player.width / 2 ||
                  posX <= playerInfo.player.width / 2) {
                ///`we cant move in X axix` outScreen
              } else {
                playerInfo
                    .updateLeftPosition(posX - (playerInfo.player.width / 2));
              }
            },
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              //TODO: backGround Color
              color: Colors.blue.withOpacity(.3),

              ///we can also choose overlay widget here, or BG Placement 🤓
            ),
          ),
        );
      },
    );
  }
}
