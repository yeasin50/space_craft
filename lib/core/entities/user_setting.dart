import 'entities.dart';

/// Singleton UserSetting
class UserSetting extends Setting {
  UserSetting._privateConstructor() {
    super.defaultSetting();
  }
  static final UserSetting _instance = UserSetting._privateConstructor();
  static UserSetting get instance => _instance;

  double get maxSensitivity => 2.0;
  double get minSensitivity => .5;

  @override
  void reset() {
    super.defaultSetting();
  }
}
