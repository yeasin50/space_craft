import 'dart:math' show Random;

import '../../../../core/entities/vector2.dart';
import '../../../../core/providers/object_scalar.dart';
import '../../models/models.dart';

final _random = Random();

///* Generates a positive random integer uniformly distributed on the range
///* from [min], inclusive, to [max], exclusive.
int next({required int min, required int max}) =>
    min + _random.nextInt(max - min);

double get _randomScreenXPos {
  double min = GObjectSize.instance.enemyShip.width;
  double max = GObjectSize.instance.screen.width - min;
  return next(min: min.toInt(), max: max.toInt()).toDouble();
}

/// Generates a positive random double `secureFrom` exclusive.
/// generated enemy should have space [an enemy ship width] between them
///* This method is expensive based on the size of `secureForm`
double _nextScreenX(List<double>? secureFrom) {
  if (secureFrom == null || secureFrom.isEmpty) {
    return _randomScreenXPos;
  } //
  else {
    late double randomDx;
    late bool isOverlapped;
    final double spaceFactor = GObjectSize.instance.enemyShip.width * 2;

    do {
      isOverlapped = false;
      randomDx = _randomScreenXPos;
      for (final x in secureFrom) {
        if ((x - randomDx).abs() < spaceFactor) {
          isOverlapped = true;
        }
      }
    } while (isOverlapped);

    return randomDx;
  }
}

/// get enemy initial position based on screen and enemy ship size
/// `secureFrom` To avoid enemy overlap confection we can take n[4-5] enemies position in count, then initial enemy
///
///* This method is expensive based on the size of `secureForm` Not in use anymore
///```
///enemyInitialPosition(
///         secureFrom: _enemies.sublist(_enemies.length - 3),
///      )
///```
///
@Deprecated(
  'Use [randomEnemyInitPosition] or [enemyInitPositionByTricker] instead. this method is too expensive based on `secureFrom`',
)
Vector2 enemyInitialPosition({
  List<EnemyShip>? secureFrom,
}) {
  final double xPos =
      _nextScreenX(secureFrom?.map((e) => e.position.dX).toList());

  // final double yPos =
  //     -_random.nextDouble() * (GObjectSize.instance.screen.height * .15);

  return Vector2(dX: xPos, dY: -60);
}

///get enemy initial position based on screen and enemy ship size
///
///To minimize the cost use `generatePartNo`
///```
/// enemyInitialPosition(generatePartNo: enemies.length %4)
/// ```
Vector2 randomEnemyInitPosition() {
  final double xPos = _randomScreenXPos;

  final double yPos =
      -_random.nextDouble() * (GObjectSize.instance.enemyShip.height * 2);

  return Vector2(dX: xPos, dY: yPos);
}

/// Depends on timer tick, test:3 final
/// ```
/// enemyInitPositionByTricker(
///   (_timerEnemyGeneration?.tick ?? 0) + index);
/// ```
Vector2 enemyInitPositionByTricker(
  int tick, {
  int numberOfPart = 3,
}) {
  final gap = GObjectSize.instance.enemyShip.width;
  final double division = GObjectSize.instance.screen.width / numberOfPart;

  final double xPos;
  switch (tick % numberOfPart) {
    case 0:
      xPos = division * _random.nextDouble() + gap;

      return Vector2(dX: xPos, dY: gap);

    default:
      xPos = (division - gap) * (tick % numberOfPart) +
          (division * _random.nextDouble());
      return Vector2(dX: xPos, dY: -gap * 2);
  }
}
