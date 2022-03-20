import 'package:flutter/material.dart';

import '../provider/provider.dart';
import '../screens/on_play/utils/enemy_hanlader.dart';
import 'model.dart';

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

class Player implements IShip {
  late final Vector2 _position;

  Player({
    required Vector2 position,
  }) : _position = position;

  ///max number of time player can live
  final int maxLive = 3;

  /// fire while player is alive and game is runnign
  bool shoot = false;

  @override
  Color get color => Colors.deepPurpleAccent;

  @override
  Size get size => GObjectSize.instatnce.playerShip;

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = PlayerHealthManager();

  @override
  ShipName get name => ShipName.player;
}

class EnemyShip implements IShip {
  final Vector2 _position;

  ///image State, helps to animate currently we have two image per ship
  /// [0,1]
  // ShipImageState state;

  final ShipName _name;

  EnemyShip({
    required Vector2 position,
    ShipName? name,
  })  : _position = position,
        _name = name ?? randomEnemyName;

  @override
  Size size = GObjectSize.instatnce.enemyShip;

  @override
  Color get color => getShipColor(shipName: name);

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = NEnemyHealthManager();

  @override
  ShipName get name => _name;
}
