import 'package:flutter/foundation.dart';

enum PlayMode { easy, medium, hard }

enum ControlMode { touch, keyboard, both }

abstract class Setting {
  late bool _music;
  late bool _sound;
  late bool _effect;
  late double _movementSensivity;
  late PlayMode _playmode;
  late ControlMode _controlMode;

  ///background music while playing the game
  bool get music => _music;

  /// bullet and other effect sound
  bool get sound => _sound;

  /// will it render extra effect on UI
  bool get effect => _effect;

  /// ship movement speed on keyboard controll mode
  double get movementSensivity => _movementSensivity;

  /// user can select [PlayMode]; enemy movement and generation depend on it
  PlayMode get playmode => _playmode;

  /// [ControlMode.touch]  used to on touch screen device[android,ios] and [ControlMode.keyboard] used for computer
  ControlMode get controlMode => _controlMode;

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
    return 'Setting(_music: $_music, _sound: $_sound, _movementSensivity: $_movementSensivity, _playmode: $_playmode, _controlMode: $_controlMode, _effect: $_effect)';
  }
}

class UserSetting extends Setting with ChangeNotifier {
  ///
  double get maxSensivity => 2.0;
  double get minSensivity => .5;

  UserSetting() {
    defaultSetting();
  }

  @override
  void update({
    bool? music,
    bool? sound,
    bool? effect,
    double? movementSensitvity,
    PlayMode? playMode,
    ControlMode? controlMode,
  }) {
    _music = music ?? _music;
    _sound = sound ?? _sound;
    _effect = effect ?? _effect;
    _movementSensivity = movementSensitvity ?? _movementSensivity;
    _playmode = playMode ?? _playmode;
    _controlMode = controlMode ?? _controlMode;

    notifyListeners();
  }

  @override
  void defaultSetting() {
    _music = true;
    _sound = true;
    _effect = true;
    _movementSensivity = 1.0;
    _playmode = PlayMode.easy;
    _controlMode = ControlMode.touch;

    notifyListeners();
  }
}
