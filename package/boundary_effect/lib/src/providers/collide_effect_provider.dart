part of boundary_effect;

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
  ///window size
  Size? size;

  PlayerBCollideEffect();

  /// initialize the provider
  void init({required Size size}) {
    size = size;
  }

  /// ship collide on specific point
  Vector2? _collidePoint;
  Vector2? get collidePoint => _collidePoint;

  ///
  final double observablePX = 20;

  final List<BoundarySide> _blockedSides = [];
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
    //todo: check if need for player
    // _collidePoint = point;
    // _refinePoint(point);

    notifyListeners();
  }

  @Deprecated(
    'Use setPointAndBoundarySide instead. player_movement_handler updated with [BoundarySide]',
  )
  void _setCollideSides(Vector2 point) {
    if (size == null) {
      log("Size is needed to be initlize\n use `init` ");
      throw NullThrownError();
    }
    if (point.dX < -observablePX &&
        !_blockedSides.contains(BoundarySide.left)) {
      _blockedSides.add(BoundarySide.left);
    }
    if (point.dX > size!.width + observablePX &&
        !_blockedSides.contains(BoundarySide.right)) {
      _blockedSides.add(BoundarySide.right);
    }

    if (point.dY < 0 && !_blockedSides.contains(BoundarySide.top)) {
      _blockedSides.add(BoundarySide.top);
    }
    if (point.dY > size!.height + observablePX &&
        !_blockedSides.contains(BoundarySide.bottom)) {
      _blockedSides.add(BoundarySide.bottom);
    }
  }

  Vector2 _refinePoint(Vector2 point) {
    if (size == null) {
      log("Size is needed to be initialize");
      throw NullThrownError();
    }
    return Vector2(
        dX: point.dX < 0
            ? 0
            : point.dX > size!.width
                ? size!.width
                : point.dX,
        dY: point.dY < 0
            ? 0
            : point.dY > size!.height
                ? size!.height
                : point.dY);
  }
}
