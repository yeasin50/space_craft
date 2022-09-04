import 'package:space_craft/core/entities/entities.dart';

class DesktopUserSetting extends Setting {
  DesktopUserSetting() {
    super.defaultSetting();
  }

  @override
  ControlMode get controlMode => ControlMode.both;

  @override
  void reset() {
    super.defaultSetting();
    controlMode = ControlMode.both;
  }
}
