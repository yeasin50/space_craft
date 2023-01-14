import 'dart:developer';

import 'package:boundary_effect/boundary_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_craft/feature/on_play/widgets/game_over_overlay.dart';
import 'package:space_craft/feature/on_play/widgets/mouse_position_tracker.dart';

import '../../core/providers/providers.dart';
import '../../core/widget/player_ship.dart';
import 'on_play.dart';
import 'provider/provider.dart';

class OnPlayScreen extends StatelessWidget {
  static const String routeName = "/on_play_screen";
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = FocusNode();
    bool onPlayHasBeenTriggered = false;
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

            if (onPlayHasBeenTriggered == false) {
              ref.watch(gameManagerProvider.notifier).onPlay();
              onPlayHasBeenTriggered = true;
            }

            return RawKeyboardListener(
              autofocus: true,
              focusNode: f,
              onKey: (event) {
                updatePlayerPosition(widgetRef: ref, rawKeyEvent: event);
              },
              child: Scaffold(
                body: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const BoundaryGlowEffect(
                      key: ValueKey("BoundaryGlowEffect widget:OnPlayScreen"),
                    ),
                    _playerShip(playerInfo),

                    // enemy ships and enemy's bullets

                    EnemyOverlay(
                      key: const ValueKey("EnemyOverlay key"),
                      enemyNotifier: enemyNotifier,
                      constraints: constraints,
                    ),

                    //player ship's bullet
                    ..._playerBullets(playerInfo),

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

                    const Align(
                      child: GameOverOverlay(),
                    )
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
