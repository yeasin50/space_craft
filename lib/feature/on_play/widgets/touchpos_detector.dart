import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enums/enums.dart';
import '../../../core/providers/game_manager.dart';
import '../provider/provider.dart';
import '../utils/utils.dart';

//this widget gonna handle UI Touch Position
class TouchPositionDetector extends StatelessWidget {
  const TouchPositionDetector({
    Key? key,
    required this.constraints,
    this.child,
  }) : super(key: key);

  final BoxConstraints constraints;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final playerInfo = ref.read(playerInfoProvider);
        final gameManager = ref.read(gameManagerProvider.notifier);
        return GestureDetector(
          // behavior: HitTestBehavior.translucent,
          onTap: () {
            // debugPrint("on onPanUpdate");
          },
          onPanDown: (details) {
            // debugPrint("$gameManager");
            if (gameManager.mode != GameMode.playing) return;

            playerInfo.startShooting();
            updatePlayerPosition(
              offset: details.localPosition,
              // constraints: constraints,
              playerInfoNotifier: playerInfo,
            );
          },
          onTapUp: (details) {
            // handle quick tap up
            playerInfo.stopShooting();
          },
          onPanEnd: (details) {
            //handle drag tapUp
            playerInfo.stopShooting();
          },
          onPanUpdate: (details) {
            if (gameManager.mode != GameMode.playing) return;
            updatePlayerPosition(
              offset: details.localPosition,
              // constraints: constraints,
              playerInfoNotifier: playerInfo,
            );
          },
          child: child,
        );
      },
    );
  }
}
