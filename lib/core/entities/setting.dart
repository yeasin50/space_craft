/// play game on different mode, easy, medium and  hard
enum GamePlayMode { easy, medium, hard }

///whether player will be able to play with touch or keyboard or both
enum ControlMode { touch, keyboard, both }

/// abstract class of game setting
abstract class Setting {
  /// bullet and other effect sound
  late bool music;

  /// bullet and other effect sound
  late bool sound;

  /// will it render extra effect on UI
  late bool effect;

  /// ship movement speed on keyboard controls mode
  late double movementSensitivity;

  /// user can select [GamePlayMode]; enemy movement and generation depend on it
  late GamePlayMode gamePlayMode;

  /// [ControlMode.touch]  used to on touch screen device[android,ios] and [ControlMode.keyboard] used for computer
  late ControlMode controlMode;

  ///reset to default
  void defaultSetting();

  ///update  user setting, optional param, null will be replaced by default/init value
  void update({
    bool? music,
    bool? sound,
    bool? effect,
    double? movementSensitivity,
    GamePlayMode? playMode,
    ControlMode? controlMode,
  });

  @override
  String toString() {
    return 'Setting(_music: $music, _sound: $sound, movementSensitivity: $movementSensitivity, gamePlayMode: $gamePlayMode, _controlMode: $controlMode, _effect: $effect)';
  }
}
