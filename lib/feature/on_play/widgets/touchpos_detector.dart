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

  void _updatePlayerPos({
    required GameMode mode,
    required Offset localPosition,
    required PlayerInfoNotifier playerInfoNotifier,
  }) {
    switch (mode) {
      case GameMode.play:
      case GameMode.resumed:
        updatePlayerPosition(
          offset: localPosition,
          playerInfoNotifier: playerInfoNotifier,
        );
        return;
      default:
    }
  }

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
            _updatePlayerPos(
                localPosition: details.localPosition,
                mode: gameManager.mode,
                playerInfoNotifier: playerInfo);
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
            _updatePlayerPos(
                localPosition: details.localPosition,
                mode: gameManager.mode,
                playerInfoNotifier: playerInfo);
          },
          child: child,
        );
      },
    );
  }
}
