import '../constants/constants.dart';
import 'provider.dart';

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
  }

  void paused() {
    state = GameMode.paused;
    ref.read(playerInfoProvider).pauseMode();
  }

  void resumed() => state = GameMode.resumed;
  void restart() => state = GameMode.restart;

  GameMode get mode => state;

  @override
  void dispose() {
    super.dispose();
  }
}
