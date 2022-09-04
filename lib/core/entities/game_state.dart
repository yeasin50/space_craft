abstract class GameState {
  /// before the start or end of the game
  /// can be used as init and dispose state
  void idle();

  /// while playing the game
  void onPlay();

  /// game is paused during play mode
  void onPause();

  /// can be resume after the pause mode
  void onResume();

  /// restart the game
  void onReset();

}
