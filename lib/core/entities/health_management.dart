import 'entities.dart';

/// Damage dealer:on bullet, ship
///
abstract class IShipHealth {
  double health();
}

abstract class OnObstacleHit {

  /// when object is get hit by bullet
  void onBulletHit({GameObject? gameObject});

  /// when ship get hit by energyBox
  void onEnergyHit({GameObject? gameObject});

  //when ship get hit by another ship
  void onShipHit({GameObject? gameObject});

  // when ship,bullet,[GameObject] get hit by boundary 
  void onBorderHit({GameObject? gameObject});
}
