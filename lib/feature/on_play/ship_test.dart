import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/object_scalar.dart';
import 'on_play.screen.dart';

import 'utils/helpers/player_movement_handler.dart';

class ShipMovementTest extends ConsumerWidget {
  ShipMovementTest({Key? key}) : super(key: key);
  final double movementRate = 2.0;

  final f = FocusNode();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: f,
        autofocus: true,
        onKey: (event) {
          updatePlayerPosition(
            rawKeyEvent: event,
            widgetRef: ref,
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            GObjectSize.init(
                size: Size(constraints.maxWidth, constraints.maxHeight));

            return const OnPlayScreen();
          },
        ),
      ),
    );
  }
}
