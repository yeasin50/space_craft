import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_craft/model/model.dart';

import '../../provider/provider.dart';
import '../screens.dart';

class ShipMovemntTest extends ConsumerWidget {
  ShipMovemntTest({Key? key}) : super(key: key);
  final double movementRate = 2.0;

  final f = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfoNotifier = ref.watch(playerInfoProvider);

    return Scaffold(
      body: RawKeyboardListener(
        focusNode: f,
        onKey: (event) {
          Vector2 moveTo = playerInfoNotifier.player.position;

          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            playerInfoNotifier.updatePosition(dY: moveTo.dX -= movementRate);
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            playerInfoNotifier.updatePosition(dY: moveTo.dX += movementRate);
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            // moveTo.dY -= movementRate;
            playerInfoNotifier.updatePosition(dY: moveTo.dY -= movementRate);
            // moveTo = Vector2(dX: 40, dY: 200);
          }
          if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            playerInfoNotifier.updatePosition(dY: moveTo.dY += movementRate);
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            GObjectSize.init(
                size: Size(constraints.maxWidth, constraints.maxHeight));

            return Stack(
              children: [
                Positioned(
                  top: playerInfoNotifier.player.position.dY,
                  left: playerInfoNotifier.player.position.dX,
                  child: const PlayerShip(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
