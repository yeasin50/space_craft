import 'package:space_craft/core/entities/entities.dart';

/// Damage dealer:on bullet, ship
///
abstract class IShipHealth {
  double health();
}

abstract class OnObstacleHit {
  void onBulletHit();
  void onEnergyHit();
  void onShipHit();
  void onBorderHit({GameObject? ship});
}
