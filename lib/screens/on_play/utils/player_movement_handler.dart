import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';

/// update player position by maintaining border
///
/// `playerInfoNotifier` player provider instance, you can pass context too
///
/// `constraints` current screen size
///
/// `offset` current touch position
void updatePlayerPosition({
  required PlayerInfoNotifier playerInfoNotifier,
  // required Size constraints,
  required Offset offset,
}) {
  final double posY = offset.dy;
  final double posX = offset.dx;

  // we are separating in two section, it'll help to move though another axis stuck
  // it'll make sure that even One axis will work even other axis stuc
  if (posY >=
          GObjectSize.instatnce.screen.height -
              playerInfoNotifier.player.size.height / 2 ||
      posY <= playerInfoNotifier.player.size.height / 2) {
    ///`we cant move in Y axix` outScreen
    ///may Add some effect like wave
  } else {
    playerInfoNotifier.updatePosition(
        dY: posY - (playerInfoNotifier.player.size.height / 2));
  }
  if (posX >=
          GObjectSize.instatnce.screen.width -
              playerInfoNotifier.player.size.width / 2 ||
      posX <= playerInfoNotifier.player.size.width / 2) {
    ///`we cant move in X axix` outScreen
  } else {
    playerInfoNotifier.updatePosition(
        dX: posX - (playerInfoNotifier.player.size.width / 2));
  }
}

///*keyboardMovement update player position by maintaining border
///
/// `playerInfoNotifier` player provider instance, you can pass context too
///
/// `constraints` current screen size
void keyboardMovementHandler({
  required PlayerInfoNotifier playerInfoNotifier,
  // required BoxConstraints constraints,
  required RawKeyEvent event,
}) {
  // debugPrint("keyboardMovementHandler Key pressed ${event.data}");

  if (event is! RawKeyDownEvent) return;

  Vector2 moveTo = playerInfoNotifier.player.position.copyWith();

  //FIXME: 1st keyStrock isnto working on [A,S,D,E]:
  //hint; maybe fixed by changing longPressed delayed

  //move left; moveable when dX>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
      event.isKeyPressed(LogicalKeyboardKey.keyA)) {
    final double x = moveTo.dX - GObjectSize.instatnce.movementRatio;

    moveTo.update(dX: x < 0 ? 0 : x);
    // if (x >= 0) {
    //   debugPrint("keyboardMovementHandler: show left glowing border");
    // }
  }

  //move right; when dx< screenWidth-playerWidth
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
      event.isKeyPressed(LogicalKeyboardKey.keyD)) {
    final x = moveTo.dX + GObjectSize.instatnce.movementRatio;
    final maxPossibleX = GObjectSize.instatnce.screen.width -
        playerInfoNotifier.player.size.width;

    moveTo.update(dX: x > maxPossibleX ? maxPossibleX : x);
    // if (x > maxPossibleX) {
    //   debugPrint("keyboardMovementHandler: glow right wall");
    // }
  }
  // move up ; when dY>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
      event.isKeyPressed(LogicalKeyboardKey.keyW)) {
    final double y = moveTo.dY - GObjectSize.instatnce.movementRatio;

    moveTo.update(dY: y < 0 ? 0 : y);
    // if (y < 0) {
    //   debugPrint("keyboardMovementHandler: glow Up");
    // }
  }
  //move down ; dY< screenWidth-playerHeight
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
    final y = moveTo.dY + GObjectSize.instatnce.movementRatio;
    final possibleHeight = GObjectSize.instatnce.screen.height -
        GObjectSize.instatnce.playerShip.height;

    moveTo.update(dY: y > possibleHeight ? possibleHeight : y);

    // if (y >= possibleHeight) {
    //   debugPrint("keyboardMovementHandler: glow down");
    // }
  }

  if (playerInfoNotifier.player.position != moveTo) {
    playerInfoNotifier.updatePosition(dX: moveTo.dX, dY: moveTo.dY);
    debugPrint("update value");
  } else {
    debugPrint("isnot updating");
  }
}
