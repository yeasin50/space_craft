import 'entities.dart';

/// Singleton UserSetting
class UserSetting extends Setting {
  UserSetting._privateConstructor() {
    defaultSetting();
  }
  static final UserSetting _instance = UserSetting._privateConstructor();
  static UserSetting get instance => _instance;

  double get maxSensitivity => 2.0;
  double get minSensitivity => .5;

  @override
  void defaultSetting() {
    music = true;
    sound = true;
    effect = true;
    movementSensitivity = 1.0;
    gamePlayMode = GamePlayMode.easy;
    controlMode = ControlMode.touch;
  }

  @override
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
}
