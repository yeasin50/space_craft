import 'package:space_craft/core/entities/entities.dart';

/// Damage dealer:on bullet, ship
///
abstract class IShipHealth {
  double health();
}

abstract class OnObstacleHit {
  void onBulletHit({GameObject? gameObject});
  void onEnergyHit({GameObject? gameObject});
  void onShipHit({GameObject? gameObject});
  void onBorderHit({GameObject? gameObject});
}
