 
import '../../domain/entities/entities.dart';

/// Singleton UserSetting
class UserSetting extends Setting {
  UserSetting._privateConstructor() {
    defaultSetting();
  }
  static final UserSetting _instance = UserSetting._privateConstructor();
  static UserSetting get instance => _instance;

  double get maxSensivity => 2.0;
  double get minSensivity => .5;

  @override
  void defaultSetting() {
    music = true;
    sound = true;
    effect = true;
    movementSensitivity = 1.0;
    playmode = PlayMode.easy;
    controlMode = ControlMode.touch;
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
    this.music = music ?? this.music;
    this.sound = sound ?? this.sound;
    this.effect = effect ?? this.effect;
    movementSensitivity = movementSensitvity ?? movementSensitivity;
    playmode = playMode ?? playmode;
    this.controlMode = controlMode ?? this.controlMode;
  }
}
