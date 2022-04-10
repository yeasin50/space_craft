import 'package:flutter/material.dart';

import '../../provider/provider.dart';
import '../../widget/widget.dart';
import 'on_play.dart';

class OnPlayScreen extends StatelessWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = FocusNode();

    return LayoutBuilder(
      builder: (context, constraints) {
        GObjectSize.init(
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return Consumer(
          builder: (context, ref, child) {
            final playerInfo = ref.watch(playerInfoProvider);
            return RawKeyboardListener(
              autofocus: true,
              focusNode: f,
              onKey: (event) {
                keyboardMovementHandler(
                  event: event,
                  playerInfoNotifier: playerInfo,
                );
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    AnimatedPositioned(
                      key: const ValueKey("playerShipAnimatedPosition"),
                      duration: GObjectSize.instatnce.animationDuration,
                      top: playerInfo.player.position.dY,
                      left: playerInfo.player.position.dX,
                      child: const PlayerShip(),
                    ),

                    // enemy ships and enemy's bullets
                    EnemyOverlay(key: UniqueKey()),

                    //todo:fixed blust and animate
                    //player ship's bullet
                    ...playerInfo.bullets.map((b) {
                      return Positioned(
                        // key: UniqueKey(),
                        // duration: GObjectSize.instatnce.animationDuration,
                        top: b.position.dY,
                        left: b.position.dX,
                        child: BulletWidget(
                          bulletHeight: b.size.height,
                          color: b.color,
                          downward: false,
                        ),
                      );
                    }).toList(),

                    //player Health, ScoreBar
                    Positioned(
                      // duration: GObjectSize.instatnce.animationDuration,
                      top: 16,
                      left: 16,
                      child: ScoreHealthBar(
                        heartHeight: 30,
                        playerInfoNotifier: playerInfo,
                      ),
                    ),

                    // healing Objects
                    // const HealingPortionOverlay(),

                    /// special power player

                    /// detect touch on bottom
                    TouchPositionDetector(
                      constraints: constraints,
                    ),

                    // game pause, restart, settings
                    const Align(
                      key: ValueKey("controllBar"),
                      alignment: Alignment(-.95, -.95),
                      child: GameControllBar(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
