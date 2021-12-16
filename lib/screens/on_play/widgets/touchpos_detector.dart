import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
import '../utils/utils.dart';

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
              updatePlayerPosition(
                offset: details.localPosition,
                constraints: constraints,
                playerInfoNotifier: playerInfo,
              );
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
              updatePlayerPosition(
                offset: details.localPosition,
                constraints: constraints,
                playerInfoNotifier: playerInfo,
              );
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
