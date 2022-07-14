/// play game on different mode, easy, medium and  hard
enum GamePlayMode { easy, medium, hard }

///whether player will be able to play with touch or keyboard or both
enum ControlMode {
  /// touch event on UI, or mouse drag
  touch,

  keyboard,

  both,
}

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

  /// max ship movement speed on keyboard controls mode
  double get maxSensitivity => 2.0;

  /// min ship movement speed on keyboard controls mode
  double get minSensitivity => .5;

  /// user can select [GamePlayMode]; enemy movement and generation depend on it
  late GamePlayMode gamePlayMode;

  /// [ControlMode.touch]  used to on touch screen device[android,ios] and [ControlMode.keyboard] used for computer
  late ControlMode controlMode;

  /// default setting with
  /// ```
  /// music = true;
  /// sound = true;
  /// effect = true;
  /// movementSensitivity = 1.0;
  /// gamePlayMode = GamePlayMode.easy;
  /// controlMode = ControlMode.touch;
  /// ```
  void defaultSetting() {
    music = true;
    sound = true;
    effect = true;
    movementSensitivity = 1.0;
    gamePlayMode = GamePlayMode.easy;
    controlMode = ControlMode.touch;
  }

  ///update  user setting, optional param, null will be replaced by default/init value
  void update({
    bool? music,
    bool? sound,
    bool? effect,
    double? movementSensitivity,
    GamePlayMode? playMode,
    ControlMode? controlMode,
  }) {
    this.music = music ?? this.music;
    this.sound = sound ?? this.sound;
    this.effect = effect ?? this.effect;
    movementSensitivity = movementSensitivity ?? movementSensitivity;
    gamePlayMode = playMode ?? gamePlayMode;
    this.controlMode = controlMode ?? this.controlMode;
  }

  void reset();

  @override
  String toString() {
    return 'Setting(_music: $music, _sound: $sound, movementSensitivity: $movementSensitivity, gamePlayMode: $gamePlayMode, _controlMode: $controlMode, _effect: $effect)';
  }
}
