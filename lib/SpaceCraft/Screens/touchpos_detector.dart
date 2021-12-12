import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//this widget gonna handle UI Touch Position
class TouchPositionDetector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          // onTap: () => print("taped"),
          onPanUpdate: (details) {
            /// touch possition
            var posX = details.globalPosition.dx;
            var posY = details.globalPosition.dy;

            /// we are separating in two section, it'll help to move though another axis stuck
            /// it'll make sure that even One axis will work even other axis stuc
            // if (posY >=
            //         constraints.maxHeight -
            //             playerPositionNotifier.player.height / 2 ||
            //     posY <= playerPositionNotifier.player.height / 2) {
            //   ///`we cant move in Y axix` outScreen
            //   ///may Add some effect like wave
            // } else {
            //   playerPositionNotifier.updateTopPosition(
            //       posY - (playerPositionNotifier.player.height / 2));
            // }
            // if (posX >=
            //         constraints.maxWidth -
            //             playerPositionNotifier.player.width / 2 ||
            //     posX <= playerPositionNotifier.player.width / 2) {
            //   ///`we cant move in X axix` outScreen
            // } else {
            //   playerPositionNotifier.updateLeftPosition(
            //       posX - (playerPositionNotifier.player.width / 2));
            // }
          },
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            //backGround Color
            color: Colors.blue.withOpacity(.3),

            ///we can also choose overlay widget here, or BG Placement 🤓
          ),
        ),
      );
    });
  }
}
