import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/game_manager.dart';
import '../../../core/widget/widget.dart';
import '../../../core/providers/object_scalar.dart';
import '../../setting/setting.dart';

class GameControlBar extends StatefulWidget {
  const GameControlBar({
    Key? key,
  }) : super(key: key);

  @override
  _GameControlBarState createState() => _GameControlBarState();
}

class _GameControlBarState extends State<GameControlBar>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = const Duration(milliseconds: 400);
  //status of pause/menu button, on Expand show others options
  bool isExpanded = false;
  late AnimationController _playPauseButtonController;

  bool _settingIsPressed = false;

  void _initAnimation() {
    _playPauseButtonController = AnimationController(
      vsync: this,
      duration: animationDuration,
      reverseDuration: animationDuration,
    );
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _playPauseButtonController.dispose();
    super.dispose();
  }

  //play-pause button changes, close remaining  overLay
  void _onPlayPauseButtonChange(ref) {
    isExpanded = !isExpanded;

    if (isExpanded) {
      _settingIsPressed = true;
      //* pause the game
      _playPauseButtonController.forward();
      ref.read(gameManagerProvider.notifier).onPause();
    } else {
      //* resume the game
      _settingIsPressed = false;
      _playPauseButtonController.reverse();
      ref.read(gameManagerProvider.notifier).onResume();
      // debugPrint("on ControlBar Resume: ${ref.read(gameManagerProvider)}");
    }

    setState(() {});
  }

  //todo: change icons color
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Stack(
        alignment: Alignment.center,
        children: [
          // backgrounds
          Positioned(
            key: const ValueKey("rotated-background-setting-logo"),
            top: GObjectSize.instance.screen.height / 2 -
                GObjectSize.instance.minLength * .3,
            left: GObjectSize.instance.screen.width / 2,
            child: AnimatedScale(
              duration: animationDuration,
              scale: _settingIsPressed ? 1 : 0,
              alignment: Alignment.centerLeft,
              child: RotateWidget(
                reverseOnRepeat: false,
                rotateAxis: const [false, false, true],
                child: Icon(
                  Icons.settings,
                  size: GObjectSize.instance.minLength * .3,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          ///tap-able widgets
          Align(
            alignment: const Alignment(.9, -.9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  alignment: Alignment.centerRight,
                  duration: animationDuration,
                  scale: isExpanded ? 1 : 0,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        key: const ValueKey("user-setting-IconButton"),
                        onTap: () {
                          // we just have single setting on UI,
                          // on multi-icons separate the operation
                          _onPlayPauseButtonChange(ref);
                        },
                        child: AnimatedScale(
                          duration: animationDuration,
                          alignment: Alignment.center,
                          scale: _settingIsPressed ? 1.25 : 1,
                          child: RotateWidget(
                            rotateAxis: const [true, true, true],
                            child: Icon(
                              Icons.settings,
                              color: _settingIsPressed
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  // behavior: HitTestBehavior.translucent,
                  onPressed: () => _onPlayPauseButtonChange(ref),
                  icon: AnimatedIcon(
                    color: Colors.white,
                    icon: AnimatedIcons.pause_play, // may changes later
                    progress: _playPauseButtonController,
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: SettingDialogWidget(
              isOpen: _settingIsPressed,
              onClose: () {
                debugPrint("close the dialog");
                _onPlayPauseButtonChange(ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
