import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_craft/core/providers/object_scalar.dart';

import '../../../core/entities/entities.dart';

enum BoundarySide {
  top,
  left,
  bottom,
  right,
}

/// player[PlayerBCollideEffect] boundary collide effect provider
final playerBoundaryCollisionProvider =
    ChangeNotifierProvider<PlayerBCollideEffect>((ref) {
  return PlayerBCollideEffect();
});

/// PlayerBoundaryCollidePosition effect
/// effect only show when it reaches the max strength
class PlayerBCollideEffect with ChangeNotifier {
  Vector2? _collidePoint;
  Vector2? get collidePoint => _collidePoint;

  ///
  final double observablePX = 20;

  final List<BoundarySide> _blockedSides = [];
  List<BoundarySide> get collideSides => _blockedSides;

  void clearCollidePoint() {
    if (_blockedSides.isEmpty && _collidePoint == null) return;
    _blockedSides.clear();
    _collidePoint = null;
    notifyListeners();
  }

  // set the collide point
  void setCollidePoint({
    required Vector2 point,
  }) {
    _setCollideSides(point);
    _collidePoint = _refinePoint(point);

    debugPrint(_blockedSides.toString());
    notifyListeners();
  }

  void _setCollideSides(Vector2 point) {
    if (point.dX < -observablePX &&
        !_blockedSides.contains(BoundarySide.left)) {
      _blockedSides.add(BoundarySide.left);
    }
    if (point.dX > GObjectSize.instance.screen.width + observablePX &&
        !_blockedSides.contains(BoundarySide.right)) {
      _blockedSides.add(BoundarySide.right);
    }

    if (point.dY < -observablePX && !_blockedSides.contains(BoundarySide.top)) {
      _blockedSides.add(BoundarySide.top);
    }
    if (point.dY > GObjectSize.instance.screen.height + observablePX &&
        !_blockedSides.contains(BoundarySide.bottom)) {
      _blockedSides.add(BoundarySide.bottom);
    }
  }

  Vector2 _refinePoint(Vector2 point) {
    return Vector2(
        dX: point.dX < 0
            ? 0
            : point.dX > GObjectSize.instance.screen.width
                ? GObjectSize.instance.screen.width
                : point.dX,
        dY: point.dY < 0
            ? 0
            : point.dY > GObjectSize.instance.screen.height
                ? GObjectSize.instance.screen.height
                : point.dY);
  }
}

// //todo: use to show effect, we may just return Offset instead of enums

// ///playerShip border collision
// List<BoundarySide> playerMoveable({
//   required Size playerSize,
//   required Vector2 touchPosition,
// }) {
//   final double posY = touchPosition.dY;
//   final double posX = touchPosition.dX;

//   List<BoundarySide> blocked = [];

//   //top collision checker
//   if (posY <= 0) {
//     blocked.add(BoundarySide.top);
//   }

//   //bottom collision checker
//   if (posY >= GObjectSize.instance.screen.height - playerSize.height) {
//     blocked.add(BoundarySide.bottom);
//   }

//   // right collision checker
//   if (posX >= GObjectSize.instance.screen.width - playerSize.width) {
//     blocked.add(BoundarySide.right);
//   }

//   //left collision checker
//   if (posX <= 0) {
//     blocked.add(BoundarySide.left);
//   }

//   return blocked;
// }
