/// Damage delear:on bullet, ship
abstract class IShipHealth {
  double health();
}

// enemyShip Bullet Damage
class DamageOnEB implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 1.0;

  DamageOnEB({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

///Player ship  Bullet damage
class DamageOnPB implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 5.0;

  DamageOnPB({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

/// decrease 10 when play ship collidewithEnemy ship
class DamageOnShipCollision implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 10.0;

  DamageOnShipCollision({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

//* Increase Part
/// increase health using [HealthBox]
class HealthBox implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 10.0;

  HealthBox({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() + decreaseHealth;
}

/// Player health manager
class PlayerHealthManager implements IShipHealth {
  final double initalHealth = 100.0;

  @override
  double health() => initalHealth;
}

/// nomal EnemyShip health manager// not used
class NEnemyHealthManager implements IShipHealth {
  final double initalHealth = 5.0;

  @override
  double health() => initalHealth;
}
