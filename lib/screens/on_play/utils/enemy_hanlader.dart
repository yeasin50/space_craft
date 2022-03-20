import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../model/model.dart';

final _random = Random();

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
