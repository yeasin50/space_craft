import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_craft/model/model.dart';

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

int clickC = 0;

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
  if (event is! RawKeyDownEvent) {}
  final playerCurrentPosition = playerInfoNotifier.player.position;

  /// FIXME:  error on this method
  final double movementRate = 2.0;

  Vector2 moveTo = playerCurrentPosition;

  if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
      event.isKeyPressed(LogicalKeyboardKey.keyA)) {
    debugPrint("> bef  movement: ${moveTo.toString()}");
    // moveTo.dX -= movementRate;
    playerInfoNotifier.updatePosition(dY: moveTo.dX -= movementRate);
    // moveTo = Vector2(dX: 40, dY: 40);
  } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
      event.isKeyPressed(LogicalKeyboardKey.keyD)) {
    debugPrint("<bef  movement: ${moveTo.toString()}");
    playerInfoNotifier.updatePosition(dY: moveTo.dX += movementRate);
    // moveTo.dX += movementRate;
    // moveTo = Vector2(dX: 400, dY: 400);
    debugPrint("${clickC++}");
  }
  if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
      event.isKeyPressed(LogicalKeyboardKey.keyW)) {
    debugPrint("^ bef  movement: ${moveTo.toString()}");
    // moveTo.dY -= movementRate;
    playerInfoNotifier.updatePosition(dY: moveTo.dY -= movementRate);
    // moveTo = Vector2(dX: 40, dY: 200);
  }
  if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
    // debugPrint("v bef  movement: ${moveTo.toString()}");
    // moveTo.dY += movementRate;
    playerInfoNotifier.updatePosition(dY: moveTo.dY += movementRate);
    // moveTo = Vector2(dX: 440, dY: 100);
  }

  debugPrint("After movement: ${moveTo.toString()}");

  updatePlayerPosition(
    // constraints: GObjectSize.instatnce.screen,
    playerInfoNotifier: playerInfoNotifier,
    offset: Offset(moveTo.dX, moveTo.dY),
  );
}
