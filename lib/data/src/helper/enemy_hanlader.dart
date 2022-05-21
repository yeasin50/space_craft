import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/src/entities/ship.dart';
import '../repository/ship.dart';
import '../util/constants/constants.dart';

final _random = Random();

//I am using enum to get imagePath because in future I may replace this with animate Paint/Path or rive

///get random Enemy [ShipName]
ShipName get randomEnemyName =>
    // sublist to remove playerShip from index:0
    ShipName.values.sublist(1)[_random.nextInt(ShipName.values.length - 1)];

///get color based On [ShipName]
Color getShipColor({required ShipName shipName}) {
  switch (shipName) {
    case ShipName.player:
      return ColorPallet.player;

    case ShipName.enemyA:
      return ColorPallet.enemyA;

    case ShipName.enemyB:
      return ColorPallet.enemyB;

    case ShipName.enemyC:
      return ColorPallet.enemyC;

    default:
      return Colors.grey;
  }
}

/// enemy image paths file assets
String enemyShipImagePath({required EnemyShip enemy}) {
  const String _baseImagePath = "assets/images/";

  late String imageName;

  switch (enemy.name) {
    case ShipName.enemyA:
      imageName = enemy.imageState == ShipImageState.a
          ? "InvaderA1.png"
          : "InvaderA2.png";
      break;

    case ShipName.enemyB:
      imageName = enemy.imageState == ShipImageState.a
          ? "InvaderB1.png"
          : "InvaderB2.png";
      break;

    case ShipName.enemyC:
      imageName = enemy.imageState == ShipImageState.a
          ? "InvaderC1.png"
          : "InvaderC2.png";
      break;

    default:
      assert(true, "Enemy shipName is not reconized");
      break;
  }

  return _baseImagePath + imageName;
}
