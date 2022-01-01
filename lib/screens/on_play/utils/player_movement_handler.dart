import 'package:flutter/material.dart';
import 'package:space_craft/model/model.dart';

import '../../../provider/provider.dart';

/// update player position by maintaining border
void updatePlayerPosition({
  required PlayerInfoNotifier playerInfoNotifier,
  required BoxConstraints constraints,
  required Offset offset,
}) {
  final double posY = offset.dy;
  final double posX = offset.dx;

  // we are separating in two section, it'll help to move though another axis stuck
  // it'll make sure that even One axis will work even other axis stuc
  if (posY >=
          constraints.maxHeight - playerInfoNotifier.player.size.height / 2 ||
      posY <= playerInfoNotifier.player.size.height / 2) {
    ///`we cant move in Y axix` outScreen
    ///may Add some effect like wave
  } else {
    playerInfoNotifier
        .updateTopPosition(posY - (playerInfoNotifier.player.size.height / 2));
  }
  if (posX >= constraints.maxWidth - playerInfoNotifier.player.size.width / 2 ||
      posX <= playerInfoNotifier.player.size.width / 2) {
    ///`we cant move in X axix` outScreen
  } else {
    playerInfoNotifier
        .updateLeftPosition(posX - (playerInfoNotifier.player.size.width / 2));
  }
}
