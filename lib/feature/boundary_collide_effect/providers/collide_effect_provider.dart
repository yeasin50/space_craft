import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/entities/entities.dart';
import '../../../core/providers/object_scalar.dart';

/// Enum used to select screen/viewPort side
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

  List<BoundarySide> _blockedSides = [];
  List<BoundarySide> get collideSides => _blockedSides;

  void onMovement({
    required List<BoundarySide> sides,
  }) {
    if (_blockedSides.isEmpty && _collidePoint == null) return;

    _blockedSides.removeWhere((element) => sides.contains(element));

    _collidePoint = null;
    notifyListeners();
  }

  // set the collide point
  void setPointAndBoundarySide({
    required Vector2 point,
    required List<BoundarySide> sides,
  }) {
    for (final side in sides) {
      if (!collideSides.contains(side)) _blockedSides.add(side);
    }
    _collidePoint = _refinePoint(point);

    notifyListeners();
  }

  @Deprecated(
    'Use setPointAndBoundarySide instead. player_movement_handler updated with [BoundarySide]',
  )
  void _setCollideSides(Vector2 point) {
    if (point.dX < -observablePX &&
        !_blockedSides.contains(BoundarySide.left)) {
      _blockedSides.add(BoundarySide.left);
    }
    if (point.dX > GObjectSize.instance.screen.width + observablePX &&
        !_blockedSides.contains(BoundarySide.right)) {
      _blockedSides.add(BoundarySide.right);
    }

    if (point.dY < 0 && !_blockedSides.contains(BoundarySide.top)) {
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
