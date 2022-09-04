import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../feature/on_play/provider/provider.dart';
import '../entities/entities.dart';

final gameManagerProvider = StateNotifierProvider<GameManager, GamePlayState>(
  (ref) {
    return GameManager(ref);
  },
);

class GameManager extends StateNotifier<GamePlayState> with GameState {
  final StateNotifierProviderRef ref;

  GameManager(this.ref) : super(GamePlayState.idle);

  GamePlayState get mode => state;

  @override
  void dispose() {
    super.dispose();
  }

  void initialOnPlay() {
    switch (state) {
      case GamePlayState.idle:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          onPlay();
        });
        return;
      default:
    }
  }

  @override
  void idle() {
    if (state == GamePlayState.idle) return;
    state = GamePlayState.idle;
    ref.read(playerInfoProvider).idle();
    ref.read(healingObjectProvider).idle();
    ref.read(enemyProvider).idle();
  }

  @override
  void onPlay() {
    if (state == GamePlayState.play) return;
    state = GamePlayState.play;
    ref.read(playerInfoProvider).onPlay();
    ref.read(healingObjectProvider).onPlay();
    ref.read(enemyProvider).onPlay();
  }

  @override
  void onPause() {
    if (state == GamePlayState.paused) return;
    state = GamePlayState.paused;
    ref.read(playerInfoProvider).onPause();
    ref.read(healingObjectProvider).onPause();
    ref.read(enemyProvider).onPause();
  }

  @override
  void onReset() {
    if (state == GamePlayState.reset) return;
    state = GamePlayState.reset;
    ref.read(playerInfoProvider).onReset();
    ref.read(healingObjectProvider).onReset();
    ref.read(enemyProvider).onReset();
  }

  @override
  void onResume() {
    if (state == GamePlayState.resumed) return;
    state = GamePlayState.resumed;
    ref.read(playerInfoProvider).onResume();
    ref.read(healingObjectProvider).onResume();
    ref.read(enemyProvider).onResume();
  }
}
