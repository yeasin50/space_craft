import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widget/widget.dart';
import 'user_setting.dart';

///contains [SettingView] with animated close button
class SettingDialogWidget extends StatelessWidget {
  /// [ScaleTransition] duration, defaul 400 milisec
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

  void _toggle() async {
    debugPrint("TODO:Close the setting screen after end of animation");
    if (onClose != null) onClose!();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedScale(
        duration: duration,
        scale: isOpen ? 1 : 0,
        child: Column(
          children: [
            const SettingView(),
            InkWell(
              onTap: _toggle,
              child: const NeonRingWidget(
                colorSet: colorSet0,
                rotation: false,
                radius: 15,
                frameThickness: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
