import 'package:flutter/material.dart';

import '../../provider/provider.dart';
import '../../widget/widget.dart';
import 'on_play.dart';

class OnPlayScreen extends ConsumerWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfo = ref.watch(playerInfoProvider);
    final f = FocusNode();
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            GObjectSize.init(
              size: Size(constraints.maxWidth, constraints.maxHeight),
            );
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: GObjectSize.instatnce.animationDuration,
                  top: playerInfo.player.position.dY,
                  left: playerInfo.player.position.dX,
                  child: const PlayerShip(),
                ),

                // enemy ships and enemy's bullets
                EnemyOverlay(
                  constraints: constraints,
                ),

                //player ship's bullet
                ...playerInfo.bullets.map((b) {
                  return AnimatedPositioned(
                    duration: GObjectSize.instatnce.animationDuration,
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
                AnimatedPositioned(
                  duration: GObjectSize.instatnce.animationDuration,
                  top: 16,
                  left: 16,
                  child: ScoreHealthBar(
                    heartHeight: 30,
                    playerInfoNotifier: playerInfo,
                  ),
                ),

                // healing Objects
                const HealingPortionOverlay(),

                /// special power player

                /// detect touch on bottom
                TouchPositionDetector(
                  constraints: constraints,
                ),

                // game pause, restart, settings
                const Align(
                  alignment: Alignment(-.95, -.95),
                  child: GameControllBar(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
