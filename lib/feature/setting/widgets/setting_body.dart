import 'package:flutter/material.dart';

import 'user_setting.dart';

///contains [SettingView] with animated close button
class SettingDialogWidget extends StatelessWidget {
  /// [ScaleTransition] duration, default 400 millisecond
  final Duration duration;

  final bool isOpen;

  final VoidCallback? onClose;

  const SettingDialogWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 400),
    this.isOpen = true,
    this.onClose,
    required,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedScale(
        duration: duration,
        scale: isOpen ? 1 : 0,
        child: SettingView(
          onTapClose: onClose,
        ),
      ),
    );
  }
}
