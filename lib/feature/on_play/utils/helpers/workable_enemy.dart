import '../../../../core/constants/constants.dart';
import '../../../../core/extensions/enum_extension.dart';
import '../../models/models.dart';

/// whether enemy is damaged or dead 
bool isWorkable(EnemyShip ship) {
  return !ship.state.isIn([
    ShipState.glitch,
    ShipState.dead,
  ]);
}
