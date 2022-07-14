import '../../../core/entities/entities.dart';

class UserSettingProvider extends Setting {
  UserSettingProvider._privateConstructor() {
    super.defaultSetting();
  }

  static final Setting _instance = UserSettingProvider._privateConstructor();

  static Setting get instance => _instance;

  @override
  double get maxSensitivity => 2.0;

  @override
  double get minSensitivity => .5;

  @override
  void reset() {
    super.defaultSetting();
  }
}
