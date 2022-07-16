import '../../../core/entities/entities.dart';

class SpaceInvaderSettingProvider extends Setting {
  SpaceInvaderSettingProvider._privateConstructor() {
    super.defaultSetting();
  }

  static final SpaceInvaderSettingProvider _instance =
      SpaceInvaderSettingProvider._privateConstructor();

  static SpaceInvaderSettingProvider get instance => _instance;

  /// whether fire is only depend on tap/click
  bool freeFire = false;

  @override
  double get maxSensitivity => 2.0;

  @override
  double get minSensitivity => .5;

  @override
  void reset() {
    super.defaultSetting();
  }
}
