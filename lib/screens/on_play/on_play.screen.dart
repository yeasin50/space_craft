import 'package:flutter/material.dart';

import '../../provider/provider.dart';
import 'widgets/widgets.dart';

class OnPlayScreen extends ConsumerWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfo = ref.watch(playerInfoProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Align(
              child: Container(
                // color: Colors.cyanAccent.withOpacity(.3),
                child: PlayerShip(),
              ),
            )
            // Positioned(
            //   top: playerInfo.player.position2d.dY,
            //   left: playerInfo.player.position2d.dX,
            //   child: playerShip(),
            // ),

            // EnemyOverlay(
            //   constraints: constraints,
            // ),

            // ...playerInfo.bullets.map((b) {
            //   return Positioned(
            //     top: b.position.dY,
            //     left: b.position.dX,
            //     child: const Text('A'),
            //   );
            // }).toList(),

            /// detect touch on bottom
            // TouchPositionDetector(
            //   constraints: constraints,
            // ),

            // const GameControllBar(),
          ],
        );
      }),
    );
  }
}
