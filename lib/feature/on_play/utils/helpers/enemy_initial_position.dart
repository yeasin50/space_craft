import 'dart:math' show Random;

import '../../../../core/entities/vector2.dart';
import '../../../../core/utils/utils.dart';
import '../../../setting/models/models.dart';
import '../../models/models.dart';

final _random = Random();

double get _randomScreenXPos {
  double min = GObjectSize.instance.enemyShip.width;
  double max = GObjectSize.instance.screen.width - min;
  return next(min: min.toInt(), max: max.toInt()).toDouble();
}

///* Generates a positive random double `secureFrom` exclusive.
///* generated enemy should have space [an enemy ship width] between them
double _nextScreenX(List<double>? secureFrom) {
  if (secureFrom == null || secureFrom.isEmpty) {
    return _randomScreenXPos;
  } //
  else {
    //TODO: impliment
    bool isOverlapped = true;
    late double randomDx;
    final double spaceFactor = GObjectSize.instance.enemyShip.width;

    while (isOverlapped) {
      randomDx = _randomScreenXPos;
      isOverlapped = false;
      for (final x in secureFrom) {
        if (randomDx < x + spaceFactor && randomDx > x - spaceFactor) {
          isOverlapped = true;
        }
      }
      if (!isOverlapped) break;
    }

    return randomDx;
  }
}

/// get enemy initial position based on screen and enemy ship size
/// `secureFrom` To avoid enemy overlap confection we can take n[4-5] enemies position in count, then initial enemy
Vector2 enemyInitialPosition({List<EnemyShip>? secureFrom}) {
  final double xPos =
      _nextScreenX(secureFrom?.map((e) => e.position.dX).toList());

  final double yPos =
      -_random.nextDouble() * (GObjectSize.instance.screen.height * .15);

  return Vector2(dX: xPos, dY: yPos);
}
