import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/enums/enums.dart';
import '../../core/providers/game_manager.dart';
import '../setting/models/object_scalar.dart';
import 'on_play.dart';
import 'provider/provider.dart';

class OnPlayScreen extends StatelessWidget {
  static const String routeName = "/on_play_screen";
  const OnPlayScreen({Key? key}) : super(key: key);

  void _onKeyEvent(playerInfo, event) {
    keyboardMovementHandler(
      event: event,
      playerInfoNotifier: playerInfo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final f = FocusNode();

    return LayoutBuilder(
      key: const ValueKey("PrLa"),
      builder: (context, constraints) {
        GObjectSize.init(
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return Consumer(
          builder: (context, ref, child) {
            final playerInfo = ref.watch(playerInfoProvider);
            final enemyNotifier = ref.watch(enemyProvider);

            final gameState = ref.watch(gameManagerProvider);

            return RawKeyboardListener(
              autofocus: true,
              focusNode: f,
              onKey: (event) {
                /// keyEvent will only work  on playmode, maybe we will move it on player provider
                if (gameState != GameMode.playing) return;
                _onKeyEvent(playerInfo, event);
              },
              child: Scaffold(
                body: Stack(
                  children: [
                    _playerShip(playerInfo),
                    // AnimatedPositioned(
                    //   key: const ValueKey("Player Ship Widget"),
                    //   duration: GObjectSize.instatnce.animationDuration,
                    //   top: playerInfo.player.position.dY,
                    //   left: playerInfo.player.position.dX,
                    //   child: const PlayerShip(),
                    // ),

                    // enemy ships and enemy's bullets
                    EnemyOverlay(
                      key: const ValueKey("EnemyOverlay key"),
                      enemyNotifier: enemyNotifier,
                      constraints: constraints,
                    ),

                    //player ship's bullet
                    ..._playerBullets(playerInfo),
                    // ...playerInfo.bullets.map((b) {
                    //   return AnimatedPositioned(
                    //     key: ValueKey(b),
                    //     duration: GObjectSize.instatnce.animationDuration,
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
                    Positioned(
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
                      key: const ValueKey("TouchPositionDetector key"),
                      constraints: constraints,
                    ),

                    // game pause, restart, settings
                    const Align(
                      key: ValueKey("controlBar"),
                      alignment: Alignment(-.95, -.95),
                      child: GameControlBar(),
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

  List<Widget> _playerBullets(PlayerInfoNotifier playerInfoNotifier) {
    return playerInfoNotifier.bullets.map((b) {
      return AnimatedPositioned(
        key: ValueKey(b),
        duration: GObjectSize.instance.animationDuration,
        top: b.position.dY,
        left: b.position.dX,
        child: BulletWidget(
          bulletHeight: b.size.height,
          color: b.color,
          downward: false,
        ),
      );
    }).toList();
  }

  AnimatedPositioned _playerShip(PlayerInfoNotifier playerInfo) {
    return AnimatedPositioned(
      key: const ValueKey("Player Ship Widget"),
      duration: GObjectSize.instance.animationDuration,
      top: playerInfo.player.position.dY,
      left: playerInfo.player.position.dX,
      child: const PlayerShip(),
    );
  }
}
