import 'game_object.dart';
import 'health_management.dart';

// defines the ship color/image
enum ShipName {
  player,
  enemyA,
  enemyB,
  enemyC,
}

/// currently we have two image per enemyShip
enum ShipImageState { a, b }

abstract class IShip implements GameObject {
  ///ship Health per life
  final IShipHealth health;

  /// ship name will define color/image
  final ShipName name;

  IShip({
    required this.health,
    required this.name,
  });
}
