import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/providers.dart';
import '../../core/widget/player_ship.dart';
import '../boundary_collide_effect/boundary_collide_effect.dart';
import 'on_play.dart';
import 'provider/provider.dart';

class OnPlayScreen extends StatelessWidget {
  static const String routeName = "/on_play_screen";
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = FocusNode();

    return LayoutBuilder(
      key: const ValueKey("OnPlayScreen-root-widget"),
      builder: (context, constraints) {
        GObjectSize.init(
          size: Size(constraints.maxWidth, constraints.maxHeight),
        );
        return Consumer(
          builder: (context, ref, child) {
            final playerInfo = ref.watch(playerInfoProvider);
            final enemyNotifier = ref.watch(enemyProvider);
            final gameState = ref.watch(gameManagerProvider.notifier);
            gameState.initialOnPlay();

            return RawKeyboardListener(
              autofocus: true,
              focusNode: f,
              onKey: (event) {
                updatePlayerPosition(widgetRef: ref, rawKeyEvent: event);
                // _onKeyEvent(gameState.mode, playerInfo, event);
              },
              child: Scaffold(
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const BoundaryGlowEffect(
                      key: ValueKey("BoundaryGlowEffect widget:OnPlayScreen"),
                    ),
                    _playerShip(playerInfo),
                    // AnimatedPositioned(
                    //   key: const ValueKey("Player Ship Widget"),
                    //   duration: GObjectSize.instance.animationDuration,
                    //   top: playerInfo.player.position.dY,
                    //   left: playerInfo.player.position.dX,
                    //   child: const PlayerShip(),
                    // ),

                    // enemy ships and enemy's bullets
                    //FIXME: duplicate key
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
                    //     duration: GObjectSize.instance.animationDuration,
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

                    //* detect touch on bottom
                    TouchPositionDetector(
                      key: const ValueKey("TouchPositionDetector key"),
                      constraints: constraints,
                    ),

                    //* game pause, restart, settings
                    const Align(
                      key: ValueKey("controlBar"),
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
      return Positioned(
        key: ValueKey(b),
        // duration: GObjectSize.instance.animationDuration,
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
