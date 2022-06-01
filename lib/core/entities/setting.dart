enum PlayMode { easy, medium, hard }

enum ControlMode { touch, keyboard, both }

abstract class Setting {
  /// bullet and other effect sound
  late bool music;

  /// bullet and other effect sound
  late bool sound;

  /// will it render extra effect on UI
  late bool effect;

  /// ship movement speed on keyboard controll mode
  late double movementSensitivity;

  /// user can select [PlayMode]; enemy movement and generation depend on it
  late PlayMode playmode;

  /// [ControlMode.touch]  used to on touch screen device[android,ios] and [ControlMode.keyboard] used for computer
  late ControlMode controlMode;

  ///reset to default
  void defaultSetting();

  ///update  user setting, optional param, null will be replaced by default/init value
  void update({
    bool? music,
    bool? sound,
    bool? effect,
    double? movementSensitvity,
    PlayMode? playMode,
    ControlMode? controlMode,
  });

  @override
  String toString() {
    return 'Setting(_music: $music, _sound: $sound, movementSensivity: $movementSensitivity, _playmode: $playmode, _controlMode: $controlMode, _effect: $effect)';
  }
}
