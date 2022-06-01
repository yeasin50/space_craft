// enemyShip Bullet Damage
import 'package:flutter/material.dart';

import '../entities/entities.dart';
import 'object_scalar.dart';
import 'vector2.dart';

class DamageOnEB implements IShipHealth {
  IShipHealth iShipHealth;

  static String type = "abstract Iship";

  double decreaseHealth = 1.0;

  DamageOnEB({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

/// ship  Bullet damage
class DamageOnPB implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 5.0;

  DamageOnPB({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

/// decrease 10 when play ship collide withEnemy ship
class DamageOnShipCollision implements IShipHealth {
  IShipHealth iShipHealth;

  double decreaseHealth = 10.0;

  DamageOnShipCollision({
    required this.iShipHealth,
  });

  @override
  double health() => iShipHealth.health() - decreaseHealth;
}

//*---------------------------*
//*      Health Manager       *
//*---------------------------*
/// Player health manager, `initalHealth:300.0`
class PlayerHealthManager implements IShipHealth {
  final double initalHealth = 300.0;

  @override
  double health() => initalHealth;
}

/// nomal EnemyShip health manager// not used
class NEnemyHealthManager implements IShipHealth {
  final double initalHealth = 5.0;

  @override
  double health() => initalHealth;
}

//*---------------------------*
//*      Healing Part         *
//*---------------------------*
///* increase health by 10. combination of IShipHealth, GameObject
class GeneralHealingBox implements IShipHealth, GameObject {
  IShipHealth iShipHealth;

  static Size boxSize = GObjectSize.instance.healthBox;

  final Vector2 _intiObjectPos;

  final double increaseHealth = 10.0;

  GeneralHealingBox({
    required this.iShipHealth,
    Vector2? initPos,
  }) : _intiObjectPos = initPos ?? Vector2();

  @override
  double health() => iShipHealth.health() + increaseHealth;

  @override
  Color get color => Colors.amber; //color; //test cases

  @override
  Vector2 get position => _intiObjectPos;

  @override
  Size get size => boxSize;
}
