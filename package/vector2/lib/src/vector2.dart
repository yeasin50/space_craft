part of vector2;

/// Helper class TO hold position in 2D,
///`dX = Left to Right` ,,
///`dY = Top to Bottom`

// helps to get value because dart work as reference value
extension V2V on Vector2 {
  Vector2 get value => Vector2(dX: dX, dY: dY);
}

class Vector2 extends Equatable {
  double dX;
  double dY;

  Vector2({
    this.dX = 0,
    this.dY = 0,
  });

  //update [Vector2] value
  void update({
    double? dX,
    double? dY,
  }) {
    this.dX = dX ?? this.dX;
    this.dY = dY ?? this.dY;
  }

  factory Vector2.fromOffset(Offset offset) {
    return Vector2(dX: offset.dx, dY: offset.dy);
  }

  //to avoid value by reference
  factory Vector2.fromValue(Vector2 v) {
    return Vector2(dX: v.dX, dY: v.dY);
  }

  Vector2 copyWith({
    double? dX,
    double? dY,
  }) {
    return Vector2(
      dX: dX ?? this.dX,
      dY: dY ?? this.dY,
    );
  }

  @override
  String toString() => 'Vector2(dX: $dX, dY: $dY)';

  @override
  List<Object?> get props => [dX, dY];
}
