import 'package:flutter/material.dart';
import 'package:vector2/vector2.dart';

import '../../../core/constants/enums/enums.dart';
import '../../../core/entities/entities.dart';
import '../../../core/providers/object_scalar.dart';
import '../utils/helpers/enemy_handler.dart';
import 'health_management.dart';
import 'player_ship_body.dart';

/// playerShip, default life= 3x100,
///  health is controlled by [PlayerHealthManager]
class Player implements IShip {
  late final Vector2 _position;

  ShipState state;

  Player({
    required Vector2 position,
  })  : _position = position,
        state = ShipState.initial;

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
  ShipState state;

  ///image State, helps to animate currently we have two image per ship
  /// ShipImageState state;
  ///
  /// enemy ship look, it is the same ship with little movement
  ShipImageState imageState;

  // ShipImageState get imageState => _imageState;

  final ShipName _name;

  EnemyShip({
    required Vector2 position,
    this.state = ShipState.initial,
    ShipName? name,
    this.imageState = ShipImageState.a,
  })  : _position = position,
        _name = name ?? randomEnemyName;

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

  /// switch image state between A-B while [state] is null. else update [imageState] based on params
  void switchImageState({ShipImageState? state}) {
    state == null
        ? imageState == ShipImageState.a
            ? imageState = ShipImageState.b
            : imageState = ShipImageState.a
        : imageState = state;
  }
}
