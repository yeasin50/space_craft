import '../../../core/entities/entities.dart';

/// Singleton UserSetting
class DefaultUserSetting extends Setting {
  DefaultUserSetting._privateConstructor() {
    super.defaultSetting();
  }
  static final DefaultUserSetting _instance =
      DefaultUserSetting._privateConstructor();
  static DefaultUserSetting get instance => _instance;

  double get maxSensitivity => 2.0;
  double get minSensitivity => .5;

  @override
  void reset() {
    super.defaultSetting();
  }
}
