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
  if (event is! RawKeyDownEvent) return;

  Vector2 moveTo = playerInfoNotifier.player.position;

  //move left
  if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
      event.isKeyPressed(LogicalKeyboardKey.keyA)) {
    moveTo.copyWith(dX: moveTo.dX -= GObjectSize.instatnce.movementRatio);
  }
  //move right
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
      event.isKeyPressed(LogicalKeyboardKey.keyD)) {
    moveTo.copyWith(dX: moveTo.dX += GObjectSize.instatnce.movementRatio);
  }
  // move up
  if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
      event.isKeyPressed(LogicalKeyboardKey.keyW)) {
    moveTo.copyWith(dY: moveTo.dY -= GObjectSize.instatnce.movementRatio);
  }
  //move down
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
    moveTo.copyWith(dY: moveTo.dY += GObjectSize.instatnce.movementRatio);
  }

  playerInfoNotifier.updatePosition(dX: moveTo.dX, dY: moveTo.dY);
}
