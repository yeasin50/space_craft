part of boundary_effect;

/// Enum used to select screen/viewPort side
enum BoundarySide {
  top,
  left,
  bottom,
  right,
}

/// player[BoundaryCollideEffect] boundary collide effect provider
final boundaryCollisionProvider =
    ChangeNotifierProvider<BoundaryCollideEffect>((ref) {
  return BoundaryCollideEffect();
});

/// PlayerBoundaryCollidePosition effect
/// effect only show when it reaches the max strength
class BoundaryCollideEffect with ChangeNotifier {
  ///window size
  Size? windowSize;

  BoundaryCollideEffect();

  /// initialize the provider
  void init({required Size size}) {
    windowSize = size;
  }

  /// ship collide on specific point
  Vector2? _collidePoint;
  Vector2? get collidePoint => _collidePoint;

  ///
  final double observablePX = 20;

  final Set<BoundarySide> _blockedSides = {};
  List<BoundarySide> get collideSides => _blockedSides.toList();

  /// update ui on object movement
  void onMovement({
    required Size boxSize,
    required Offset boxPosition,
  }) {
    final newSides =
        _getCollideSides(boxPosition: boxPosition, boxSize: boxSize);

    _blockedSides.addAll(newSides);
    for (final side in BoundarySide.values) {
      if (newSides.contains(side) == false) {
        _blockedSides.remove(side);
      }
    }

    notifyListeners();
  }

  @Deprecated(
    'Use setPointAndBoundarySide instead. player_movement_handler updated with [BoundarySide]',
  )
  void _setCollideSides(Vector2 point) {
    if (windowSize == null) {
      log("Size is needed to be initlize\n use `init` ");
      throw NullThrownError();
    }
    if (point.dX < -observablePX &&
        !_blockedSides.contains(BoundarySide.left)) {
      _blockedSides.add(BoundarySide.left);
    }
    if (point.dX > windowSize!.width + observablePX &&
        !_blockedSides.contains(BoundarySide.right)) {
      _blockedSides.add(BoundarySide.right);
    }

    if (point.dY < 0 && !_blockedSides.contains(BoundarySide.top)) {
      _blockedSides.add(BoundarySide.top);
    }
    if (point.dY > windowSize!.height + observablePX &&
        !_blockedSides.contains(BoundarySide.bottom)) {
      _blockedSides.add(BoundarySide.bottom);
    }
  }

  Vector2 _refinePoint(Vector2 point) {
    if (windowSize == null) {
      log("Size is needed to be initialize");
      throw NullThrownError();
    }
    return Vector2(
        dX: point.dX < 0
            ? 0
            : point.dX > windowSize!.width
                ? windowSize!.width
                : point.dX,
        dY: point.dY < 0
            ? 0
            : point.dY > windowSize!.height
                ? windowSize!.height
                : point.dY);
  }

  /// update collide point on BoxMovement
  List<BoundarySide> _getCollideSides({
    required Size boxSize,
    required Offset boxPosition,
  }) {
    final xLimit = boxSize.width * .1;
    final yLimit = boxSize.height * .1;

    List<BoundarySide> collideSize = [];
    if (boxPosition.dx <= xLimit) {
      collideSize.add(BoundarySide.left);
    }
    if (boxPosition.dx >= windowSize!.width - boxSize.width - xLimit) {
      collideSize.add(BoundarySide.right);
    }
    if (boxPosition.dy <= yLimit) {
      collideSize.add(BoundarySide.top);
    }
    if (boxPosition.dy >= windowSize!.height - boxSize.height - yLimit) {
      collideSize.add(BoundarySide.bottom);
    }

    return collideSize;
  }
}
