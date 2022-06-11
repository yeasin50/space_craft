import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../../../core/widget/widget.dart';
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
            RotateWidget(
              rotateAxis: const [false, false, true],
              reverseOnRepeat: false,
              child: InkWell(
                onTap: _toggle,
                child: ClipPath(
                  clipper: CloseButtonCustomClipperPath(
                    thicknessRatio: .2,
                  ),
                  child: const NeonRingWidget(
                    colorSet: colorSet0,
                    duration: Duration(milliseconds: 100),
                    rotation: false,
                    size: 15,
                    frameThickness: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
