import 'dart:developer';

import 'package:boundary_effect/boundary_effect.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoundaryEffectExample1 extends StatelessWidget {
  const BoundaryEffectExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          const boxSize = Size.fromRadius(50);
          final ValueNotifier<Offset> boxPosition = ValueNotifier(
              Offset(constraints.maxWidth / 2, constraints.maxHeight / 2));

          boxPosition.addListener(() {
            log(boxPosition.toString());
          });
          return Stack(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  // final notifier = ref.read(playerBoundaryCollisionProvider(
                  //     Size(constraints.maxWidth, constraints.maxHeight)));
                  // notifier.setPointAndBoundarySide(point: point, sides: sides);
                  return const BoundaryGlowEffect();
                },
              ),
              ValueListenableBuilder<Offset>(
                valueListenable: boxPosition,
                builder: (context, value, child) => Positioned(
                  left: value.dx,
                  top: value.dy,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final poss = details.globalPosition;
                      log(poss.toString());
                      final xLimit = boxSize.width / 2;
                      final yLimit = boxSize.height / 2;

                      double newPosX = poss.dx;
                      double newPosY = poss.dy;
                      //recheck value/ref

                      if (newPosX < constraints.maxWidth - xLimit) {
                        newPosX = poss.dx - xLimit;
                      } else {
                        newPosX = value.dx;
                      }

                      if (newPosY > yLimit &&
                          newPosY < constraints.maxHeight - yLimit) {
                        newPosY = poss.dy - xLimit;
                      } else {
                        newPosY = value.dy;
                      }
                      boxPosition.value = Offset(newPosX, newPosY);
                    },
                    child: Container(
                      width: boxSize.width,
                      height: boxSize.height,
                      color: Colors.amber,
                      alignment: Alignment.center,
                      child: Text("Drag to Move"),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
