import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/entities/entities.dart';
import '../../../../core/providers/providers.dart';
import '../../../boundary_collide_effect/providers/collide_effect_provider.dart';
import '../../../setting/providers/providers.dart';
import '../../provider/provider.dart';

/// update player position based on touch position and keyboard movement
///* To use keyboard control, pass [rawKeyEvent]
///* To control user position by touch or mouse right click pass [offset], it is localOffset of tapped point
///
void updatePlayerPosition({
  required WidgetRef widgetRef,
  RawKeyEvent? rawKeyEvent,
  Offset? offset,
}) {
  final gamePlayState = widgetRef.read(gameManagerProvider);

  final PlayerInfoNotifier notifier = widgetRef.read(playerInfoProvider);

  switch (gamePlayState) {
    case GamePlayState.play:
    case GamePlayState.resumed:
      if (offset != null) {
        _updatePlayerPosition(
          offset: offset,
          ref: widgetRef,
        );
      }

      if (rawKeyEvent != null) {
        _keyboardMovementHandler(
            event: rawKeyEvent, playerInfoNotifier: notifier);
      }

      return;
    default:
  }
}

/// update player position by maintaining border
///
/// `playerInfoNotifier` player provider instance, you can pass context too
///
/// `constraints` current screen size
///
/// `offset` current touch position
void _updatePlayerPosition({
  required WidgetRef ref,
  // required Size constraints,
  required Offset offset,
}) {
  //skip keyboardMovement while control mode is only keyboard
  if (SpaceInvaderSettingProvider.instance.controlMode ==
          ControlMode.keyboard //
      ) return;

  final double posY = offset.dy;
  final double posX = offset.dx;

  final PlayerInfoNotifier playerInfoNotifier = ref.read(playerInfoProvider);
  final PlayerBCollideEffect collideEffect =
      ref.read(playerBoundaryCollisionProvider);
  //* we are separating in two section, it'll help to move though another axis stuck
  //* it'll make sure that even One axis will work even other axis stuck

  final List<BoundarySide> blockedSides = [
    if (posY >=
        GObjectSize.instance.screen.height -
            playerInfoNotifier.player.size.height / 2)
      BoundarySide.bottom,
    if (posY <= playerInfoNotifier.player.size.height / 2) BoundarySide.top,
    if (posX >=
        GObjectSize.instance.screen.width -
            playerInfoNotifier.player.size.width / 2)
      BoundarySide.right,
    if (posX <= playerInfoNotifier.player.size.width / 2) BoundarySide.left,
  ];

  collideEffect.setPointAndBoundarySide(
    point: playerInfoNotifier.player.position,
    sides: blockedSides,
  );

  if (!blockedSides.contains(BoundarySide.left) &&
      !blockedSides.contains(BoundarySide.right)) {
    collideEffect.onMovement(sides: [BoundarySide.left, BoundarySide.right]);
    playerInfoNotifier.updatePosition(
      dX: posX - (playerInfoNotifier.player.size.width / 2),
      // dY: posY - (playerInfoNotifier.player.size.height / 2),
    );
  }

  if (!blockedSides.contains(BoundarySide.top) &&
      !blockedSides.contains(BoundarySide.bottom)) {
    collideEffect.onMovement(sides: [BoundarySide.top, BoundarySide.bottom]);
    playerInfoNotifier.updatePosition(
      // dX: posX - (playerInfoNotifier.player.size.width / 2),
      dY: posY - (playerInfoNotifier.player.size.height / 2),
    );
  }
}

///*keyboardMovement update player position by maintaining border
///
/// `playerInfoNotifier` player provider instance, you can pass context too
///
/// `constraints` current screen size
void _keyboardMovementHandler({
  required PlayerInfoNotifier playerInfoNotifier,
  // required BoxConstraints constraints,
  required RawKeyEvent event,
}) {
  // debugPrint("keyboardMovementHandler Key pressed ${event.data}");

  //skip keyboardMovement while control mode is only touch
  if (SpaceInvaderSettingProvider.instance.controlMode == ControlMode.touch)
    return;

  if (event is! RawKeyDownEvent) return;

  Vector2 moveTo = playerInfoNotifier.player.position.copyWith();

  //FIXME: 1st keyStrock isnto working on [A,S,D,E]:
  //hint; maybe fixed by changing longPressed delayed
  //TODO: collide effect
  //move left; moveable when dX>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
      event.isKeyPressed(LogicalKeyboardKey.keyA)) {
    final double x = moveTo.dX - GObjectSize.instance.movementRatio;

    moveTo.update(dX: x < 0 ? 0 : x);
    // if (x >= 0) {
    //   debugPrint("keyboardMovementHandler: show left glowing border");
    // }
  }

  //move right; when dx< screenWidth-playerWidth
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
      event.isKeyPressed(LogicalKeyboardKey.keyD)) {
    final x = moveTo.dX + GObjectSize.instance.movementRatio;
    final maxPossibleX = GObjectSize.instance.screen.width -
        playerInfoNotifier.player.size.width;

    moveTo.update(dX: x > maxPossibleX ? maxPossibleX : x);
    // if (x > maxPossibleX) {
    //   debugPrint("keyboardMovementHandler: glow right wall");
    // }
  }
  // move up ; when dY>0
  if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
      event.isKeyPressed(LogicalKeyboardKey.keyW)) {
    final double y = moveTo.dY - GObjectSize.instance.movementRatio;

    moveTo.update(dY: y < 0 ? 0 : y);
    // if (y < 0) {
    //   debugPrint("keyboardMovementHandler: glow Up");
    // }
  }
  //move down ; dY< screenWidth-playerHeight
  else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
      event.isKeyPressed(LogicalKeyboardKey.keyS)) {
    final y = moveTo.dY + GObjectSize.instance.movementRatio;
    final possibleHeight = GObjectSize.instance.screen.height -
        GObjectSize.instance.playerShip.height;

    moveTo.update(dY: y > possibleHeight ? possibleHeight : y);

    // if (y >= possibleHeight) {
    //   debugPrint("keyboardMovementHandler: glow down");
    // }
  }

  if (playerInfoNotifier.player.position != moveTo) {
    playerInfoNotifier.updatePosition(dX: moveTo.dX, dY: moveTo.dY);
  } else {
    // debugPrint("is not updating");
  }
}
