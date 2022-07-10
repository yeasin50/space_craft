import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../feature/on_play/provider/provider.dart';
import '../entities/entities.dart';

final gameManagerProvider = StateNotifierProvider<GameManager, GameMode>(
  (ref) {
    return GameManager(ref);
  },
);

class GameManager extends StateNotifier<GameMode> with GameState {
  final StateNotifierProviderRef ref;

  GameManager(this.ref) : super(GameMode.idle);

  GameMode get mode => state;

  @override
  void dispose() {
    super.dispose();
  }

  void initialOnPlay() {
    switch (state) {
      case GameMode.idle:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          onPlay();
        });
        return;
      default:
    }
  }

  @override
  void idle() {
    if (state == GameMode.idle) return;
    state = GameMode.idle;
    ref.read(playerInfoProvider).idle();
    ref.read(healingObjectProvider).idle();
    ref.read(enemyProvider).idle();
  }

  @override
  void onPlay() {
    if (state == GameMode.play) return;
    state = GameMode.play;
    ref.read(playerInfoProvider).onPlay();
    ref.read(healingObjectProvider).onPlay();
    ref.read(enemyProvider).onPlay();
  }

  @override
  void onPause() {
    if (state == GameMode.paused) return;
    state = GameMode.paused;
    ref.read(playerInfoProvider).onPause();
    ref.read(healingObjectProvider).onPause();
    ref.read(enemyProvider).onPause();
  }

  @override
  void onReset() {
    if (state == GameMode.reset) return;
    state = GameMode.reset;
    ref.read(playerInfoProvider).onReset();
    ref.read(healingObjectProvider).onReset();
    ref.read(enemyProvider).onReset();
  }

  @override
  void onResume() {
    if (state == GameMode.resumed) return;
    state = GameMode.resumed;
    ref.read(playerInfoProvider).onResume();
    ref.read(healingObjectProvider).onResume();
    ref.read(enemyProvider).onResume();
  }
}
