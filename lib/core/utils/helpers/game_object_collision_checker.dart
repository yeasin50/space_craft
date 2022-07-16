import 'dart:ui';

import '../../entities/entities.dart';
import '../../providers/object_scalar.dart';

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

//todo: use to show effect, we may just return Offset instead of enums
enum BlockedSide { top, left, right, bottom }

///playerShip border collision
List<BlockedSide> playerMoveable({
  required Size playerSize,
  required Vector2 touchPosition,
}) {
  final double posY = touchPosition.dY;
  final double posX = touchPosition.dX;

  List<BlockedSide> blocked = [];

  //top collision checker
  if (posY <= 0) {
    blocked.add(BlockedSide.top);
  }

  //bottom collision checker
  if (posY >= GObjectSize.instance.screen.height - playerSize.height) {
    blocked.add(BlockedSide.bottom);
  }

  // right collision checker
  if (posX >= GObjectSize.instance.screen.width - playerSize.width) {
    blocked.add(BlockedSide.right);
  }

  //left collision checker
  if (posX <= 0) {
    blocked.add(BlockedSide.left);
  }

  return blocked;
}
