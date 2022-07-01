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

  GameManager(this.ref) : super(GameMode.start);

  GameMode get mode => state;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onPlay() {
    if (state == GameMode.playing) return;
    state = GameMode.playing;
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
    // TODO: implement onStart
  }

  @override
  void onResume() {
    // TODO: implement onStart
  }

  @override
  void onStart() {
    // TODO: implement onStart
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }
}
