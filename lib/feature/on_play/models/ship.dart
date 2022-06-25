import 'package:flutter/material.dart';

import '../../../core/entities/entities.dart';
import '../../../core/providers/object_scalar.dart';
import '../utils/helpers/enemy_hanlader.dart';
import 'health_management.dart';
import 'player_ship_body.dart';

/// playerShip, default life= 3x100,
///  health is controlled by [PlayerHealthManager]
class Player implements IShip {
  late final Vector2 _position;

  Player({
    required Vector2 position,
  }) : _position = position;

  ///max number of time player can live
  final int maxLive = 3;

  /// fire while player is alive and game is running
  bool shoot = false;

  @override
  Color get color => Colors.deepPurpleAccent;

  @override
  Size get size => GObjectSize.instance.playerShip;

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = PlayerHealthManager();

  @override
  ShipName get name => ShipName.player;

  /// covering my mistake with it
  /// return same as [Player] for collision checkUP
  GameObject get topPart {
    Vector2 p = Vector2(
      dX: position.dX +
          (size.width *
              (GObjectSize.instance.topWidthFactor /
                  2)), //top part moving half width
      dY: position.dY,
    );

    return PlayerShipBodyPart(
      position: p,
      size: GObjectSize.instance.playerShipTopPart,
    );
  }

  GameObject get bottomPart {
    Vector2 p = Vector2(
      dX: position.dX,
      dY: position.dY + size.height * GObjectSize.instance.topHeightFactor,
    );
    Size s = Size(
        size.width, size.height * (1 - GObjectSize.instance.topHeightFactor));
    return PlayerShipBodyPart(
      position: p,
      size: s,
    );
  }
}

class EnemyShip implements IShip {
  final Vector2 _position;

  ///image State, helps to animate currently we have two image per ship
  // ShipImageState state;
  ShipImageState _imageState;

  /// enemy ship look, it is the same ship with little movement
  ShipImageState get imageState => _imageState;

  final ShipName _name;

  EnemyShip({
    required Vector2 position,
    ShipName? name,
  })  : _position = position,
        _name = name ?? randomEnemyName,
        _imageState = ShipImageState.a;

  @override
  Size size = GObjectSize.instance.enemyShip;

  @override
  Color get color => getShipColor(shipName: name);

  @override
  Vector2 get position => _position;

  @override
  IShipHealth health = NEnemyHealthManager();

  @override
  ShipName get name => _name;

  /// switch image state between A-B while [state] is null. else update [_imageState] based on params
  void switchImageState({ShipImageState? state}) {
    state == null
        ? _imageState == ShipImageState.a
            ? _imageState = ShipImageState.b
            : _imageState = ShipImageState.a
        : _imageState = state;
  }
}
