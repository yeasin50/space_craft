 

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/constants/constants.dart';

final gameManagerProvider = StateNotifierProvider<GameManager, GameMode>(
  (ref) {
    return GameManager(ref);
  },
);

class GameManager extends StateNotifier<GameMode> {
  final StateNotifierProviderRef ref;

  GameManager(this.ref) : super(GameMode.idle);

  void idle() => state = GameMode.idle;
  void started() => state = GameMode.started;

  void playing() {
    state = GameMode.playing;
    ref.read(playerInfoProvider).payingMode();
    ref.read(healingObjectProvider).playingMode();
    ref.read(enemyProvider).playMode();
  }

  void paused() {
    state = GameMode.paused;
    ref.read(playerInfoProvider).pauseMode();
    ref.read(healingObjectProvider).pauseMode();
    ref.read(enemyProvider).pauseMode();
  }

  void resumed() => state = GameMode.resumed;
  void restart() => state = GameMode.restart;

  GameMode get mode => state;

  @override
  void dispose() {
    super.dispose();
  }
}
