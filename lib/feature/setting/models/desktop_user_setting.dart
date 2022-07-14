import 'package:space_craft/core/entities/entities.dart';

class DesktopUserSetting extends Setting {
  DesktopUserSetting() {
    super.defaultSetting();
  }

  @override
  ControlMode get controlMode => ControlMode.both;

  double get maxSensitivity => 2.0;

  double get minSensitivity => .5;

  @override
  void reset() {
    super.defaultSetting();
    controlMode = ControlMode.both;
  }
}
