import '../constants/constants.dart';
import 'provider.dart';

final gameManagerProvider = StateNotifierProvider<GameManager, GameMode>(
  (ref) {
    return GameManager();
  },
);

class GameManager extends StateNotifier<GameMode> {
  GameManager() : super(GameMode.idle);

  void idle() => state = GameMode.idle;
  void started() => state = GameMode.started;
  void playing() => state = GameMode.playing;
  void paused() => state = GameMode.paused;
  void resumed() => state = GameMode.resumed;
  void restart() => state = GameMode.restart;

  GameMode get mode => state;

  @override
  void dispose() {
    super.dispose();
  }
}
