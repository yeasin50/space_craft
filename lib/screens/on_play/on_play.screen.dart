import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:space_craft/constants/constants.dart';
import '../../provider/provider.dart';
import '../../widget/widget.dart';
import 'on_play.dart';
import 'widgets/widgets.dart';

class OnPlayScreen extends ConsumerWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfo = ref.watch(playerInfoProvider);
    final f = FocusNode(canRequestFocus: true);
    return RawKeyboardListener(
      focusNode: f,
      onKey: (event) {
        // check gameMode state if needed
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
                Positioned(
                  top: playerInfo.player.position.dY,
                  left: playerInfo.player.position.dX,
                  child: const PlayerShip(),
                ),

                // enemy ships and enemy's bullets
                // EnemyOverlay(
                //   constraints: constraints,
                // ),

                //player ship's bullet
                // ...playerInfo.bullets.map((b) {
                //   return Positioned(
                //     top: b.position.dY,
                //     left: b.position.dX,
                //     child: BulletWidget(
                //       bulletHeight: b.size.height,
                //       color: b.color,
                //       downward: false,
                //     ),
                //   );
                // }).toList(),

                //player Health, ScoreBar
                // Positioned(
                //   top: 16,
                //   left: 16,
                //   child: ScoreHealthBar(
                //     heartHeight: 30,
                //     playerInfoNotifier: playerInfo,
                //   ),
                // ),

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
