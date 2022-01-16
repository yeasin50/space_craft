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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                top: playerInfo.player.position.dY,
                left: playerInfo.player.position.dX,
                child: playerShip(),
              ),

              EnemyOverlay(
                constraints: constraints,
              ),

              ...playerInfo.bullets.map((b) {
                return Positioned(
                  top: b.position.dY,
                  left: b.position.dX,
                  child: Container(
                    height: b.size.height,
                    width: b.size.width,
                    color: b.color,
                  ),
                );
              }).toList(),

              /// detect touch on bottom
              TouchPositionDetector(
                constraints: constraints,
              ),

              Positioned(
                top: 16,
                left: 16,
                child: ScoreHealthBar(
                  heartHeight: 30,
                  playerInfoNotifier: playerInfo,
                ),
              ),

              const GameControllBar(),
            ],
          );
        },
      ),
    );
  }
}
