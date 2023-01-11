import 'dart:developer';

import 'package:boundary_effect/boundary_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoundaryEffectExample1 extends ConsumerWidget {
  const BoundaryEffectExample1({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          const boxSize = Size.fromRadius(50);
          final ValueNotifier<Offset> boxPosition = ValueNotifier(
              Offset(constraints.maxWidth / 2, constraints.maxHeight / 2));

          boxPosition.addListener(() {
            ref
                .read(boundaryCollisionProvider)
                .onMovement(boxPosition: boxPosition.value, boxSize: boxSize);
          });
          return Stack(
            children: [
              const BoundaryGlowEffect(),
              ValueListenableBuilder<Offset>(
                valueListenable: boxPosition,
                builder: (context, value, child) => Positioned(
                  left: value.dx,
                  top: value.dy,
                  child: GestureDetector(
                    onPanUpdate: (details) => _updateBlocPosition(
                      details,
                      boxPosition: boxPosition,
                      boxSize: boxSize,
                      constraints: constraints,
                      tapOffset: value,
                    ),
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

/// MessedUp method 😂
void _updateBlocPosition(
  DragUpdateDetails details, {
  required Size boxSize,
  required BoxConstraints constraints,
  required Offset tapOffset,
  required ValueNotifier<Offset> boxPosition,
}) {
  final poss = details.globalPosition;

  final xLimit = boxSize.width / 2;
  final yLimit = boxSize.height / 2;

  double newPosX = poss.dx;
  double newPosY = poss.dy;
  //recheck value/ref

  if (newPosX > xLimit && newPosX < constraints.maxWidth - xLimit) {
    newPosX = poss.dx - xLimit;
  } else {
    newPosX = tapOffset.dx;
  }

  if (newPosY > yLimit && newPosY < constraints.maxHeight - yLimit) {
    newPosY = poss.dy - xLimit;
  } else {
    newPosY = tapOffset.dy;
  }
  boxPosition.value = Offset(newPosX, newPosY);
}
