import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../widget/widget.dart';
import 'user_setting.dart';

///contains [SettingView] with animated close button
class SettingDialogWidget extends StatefulWidget {
  /// notify to show/animate the dilaog,
  /// for true value it will start aniamting forward; open the dialog
  /// for false it will reverse the animation means close the dialog
  final ValueNotifier<bool> dialogVisibleStateNotifier;

  /// [ScaleTransition] duration, defaul 400 milisec
  final Duration duration;

  const SettingDialogWidget({
    Key? key,
    required this.dialogVisibleStateNotifier,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  State<SettingDialogWidget> createState() => _SettingDialogWidgetState();
}

class _SettingDialogWidgetState extends State<SettingDialogWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    widget.dialogVisibleStateNotifier.addListener(() {
      if (widget.dialogVisibleStateNotifier.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    //TODO: recheck
    widget.dialogVisibleStateNotifier.removeListener(() {});
    widget.dialogVisibleStateNotifier.dispose();
    super.dispose();
  }

  void _toggle() {
    widget.dialogVisibleStateNotifier.value =
        !widget.dialogVisibleStateNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _animation,
            child: const SettingView(),
          ),
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
    );
  }
}
