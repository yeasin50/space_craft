import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../core/entities/matrix8x12.dart';
import '../../models/invader_matrix.dart';

import '../../../../core/constants/color_palette.dart';
import '../../../../core/entities/ship.dart';
import '../../models/ship.dart';

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

    case ShipName.enemyD:
      return Colors.cyanAccent;

    default:
      return Colors.grey;
  }
}

/// enemy image paths file assets
@Deprecated(
  'Use [getShipMatrix] instead.'
  'Breaking changes: assets has been replaced with [Matrix8x12]',
)
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
      assert(true, "Enemy shipName is not recognized");
      break;
  }

  return _baseImagePath + imageName;
}

Matrix8x12 getShipMatrix(EnemyShip enemy) {
  switch (enemy.name) {
    case ShipName.enemyA:
      return enemy.imageState == ShipImageState.a
          ? InvaderMatrixA().xState
          : InvaderMatrixA().yState;

    case ShipName.enemyB:
      return enemy.imageState == ShipImageState.a
          ? InvaderMatrixB().xState
          : InvaderMatrixB().yState;

    case ShipName.enemyC:
      return enemy.imageState == ShipImageState.a
          ? InvaderMatrixC().xState
          : InvaderMatrixC().yState;

    default:
      assert(true, "Enemy shipName is not recognized");
  }
  return InvaderMatrixA().xState;
}
