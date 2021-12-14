/// Helper class TO hold position in 2D,
///`dX = Left to Right` ,,
///`dY = Top to Bottom`
class Vector2 {
  final double dX;
  final double dY;

  const Vector2({
    this.dX = 0,
    this.dY = 0,
  });

  Vector2 copyWith({
    double? dX,
    double? dY,
  }) {
    return Vector2(
      dX: dX ?? this.dX,
      dY: dY ?? this.dY,
    );
  }
}
