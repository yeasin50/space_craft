import 'dart:math' show Random;

import '../../../../core/entities/vector2.dart';
import '../../../setting/models/models.dart';
import '../../models/models.dart';

final _random = Random();

///* Generates a positive random double uniformly distributed on the range
///* from [min], inclusive, to [max], exclusive.
double _nextScreenX({
  required double min,
  required double max,
}) =>
    min + (max * _random.nextDouble() - min);

/// get enemy initial position based on screen and enemy ship size
Vector2 enemyInitialPosition({List<EnemyShip>? secureFrom}) {
  if (secureFrom == null || secureFrom.isEmpty) {
    final double xPos = _nextScreenX(
      min: GObjectSize.instance.enemyShip.width,
      max: GObjectSize.instance.screen.width,
    );

    /// To avoid enemy overlap confection we can take n[4-5] enemies position in count, then initial enemy

    final double yPos =
        -_random.nextDouble() * (GObjectSize.instance.screen.height * .15);

    return Vector2(dX: xPos, dY: yPos);
  }

  return Vector2();
}
