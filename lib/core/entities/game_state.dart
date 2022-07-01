abstract class GameState {
  ///start of the app
  void onStart();

  /// while playing the game
  void onPlay();

  /// game is paused during play mode
  void onPause();

  /// can be resume after the pause mode
  void onResume();

  /// restart the game
  void onReset();

  /// exit the Game
  void onStop();
}
