import 'dart:ui';

import 'package:space_craft/model/model.dart';

import '../../../provider/provider.dart';

/// check collision between [GameObject]
bool collisionChecker({
  required GameObject a,
  required GameObject b,
}) {
  if (b.position.dX + b.size.width >= a.position.dX &&
      b.position.dX <= a.position.dX + a.size.width &&
      b.position.dY <= a.position.dY + a.size.height &&
      b.position.dY + b.size.height >= a.position.dY) {
    return true;
  }
  return false;
}

//todo: use to show effect, we may just return Offset instead of enmus
enum BlockedSide { top, left, right, bottom }

///playerShip border collision
List<BlockedSide> playerMoveable({
  required Size playerSize,
  required Vector2 touchPosition,
}) {
  final double posY = touchPosition.dY;
  final double posX = touchPosition.dX;

  List<BlockedSide> blocked = [];

  if (posY >= GObjectSize.instatnce.screen.height - playerSize.height / 2) {
    blocked.add(BlockedSide.bottom);
  }

  if (posY <= playerSize.height / 2) {
    blocked.add(BlockedSide.top);
  }

  if (posX >= GObjectSize.instatnce.screen.width - playerSize.width / 2) {
    blocked.add(BlockedSide.right);
  }

  if (posX <= playerSize.width / 2) {
    blocked.add(BlockedSide.left);
  }

  return blocked;
}
