import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        autofocus: true,
        onKey: (event) {
          keyboardMovementHandler(
            event: event,
            playerInfoNotifier: playerInfoNotifier,
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            GObjectSize.init(
                size: Size(constraints.maxWidth, constraints.maxHeight));

            return OnPlayScreen();
          },
        ),
      ),
    );
  }
}
