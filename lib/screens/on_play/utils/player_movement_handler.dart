import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/model.dart';
import '../../../provider/provider.dart';
import 'object_collision_checker.dart';

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
  debugPrint("keyboardMovementHandler Key pressed ${event.data}");

  if (event is! RawKeyDownEvent) return;

  Vector2 moveTo = playerInfoNotifier.player.position;


  //FIXME: 1st keyStrock isnto working on [A,S,D,E]

  //move left; moveable when dX>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
      event.isKeyPressed(LogicalKeyboardKey.keyA)) {
    final double x = moveTo.dX - GObjectSize.instatnce.movementRatio;

    if (x > 0) {
      moveTo.update(dX: x);
    }
  }
  //move right; when dx< screenWidth-playerWidth
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
      event.isKeyPressed(LogicalKeyboardKey.keyD)) {
    final x = moveTo.dX + GObjectSize.instatnce.movementRatio;
    if (x <
        GObjectSize.instatnce.screen.width -
            playerInfoNotifier.player.size.width) {
      moveTo.update(dX: x);
    }
  }
  // move up ; when dY>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
      event.isKeyPressed(LogicalKeyboardKey.keyW)) {
    final double y = moveTo.dY - GObjectSize.instatnce.movementRatio;

    if (y > 0) moveTo.update(dY: y);
  }
  //move down ; dY< screenWidth-playerHeight
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
    final y = moveTo.dY + GObjectSize.instatnce.movementRatio;
    if (y <
        GObjectSize.instatnce.screen.height -
            GObjectSize.instatnce.playerShip.height) {
      moveTo.update(dY: y);
    }

  }
  // final collisionPoints = playerMoveable(
  //   playerSize: playerInfoNotifier.player.size,
  //   touchPosition: moveTo,
  // );

  playerInfoNotifier.updatePosition(dX: moveTo.dX, dY: moveTo.dY);
}
