import '../../../../core/entities/vector2.dart';
import '../../../../core/utils/utils.dart';
import '../../../setting/models/models.dart';
import '../../models/models.dart';

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
Vector2 enemyInitialPosition({List<EnemyShip>? secureFrom}) {
  final double xPos =
      _nextScreenX(secureFrom?.map((e) => e.position.dX).toList());

  // final double yPos =
  //     -_random.nextDouble() * (GObjectSize.instance.screen.height * .15);

  return Vector2(dX: xPos, dY: -60);
}
