import 'package:flutter/material.dart';
import 'package:space_craft/utils/utils.dart';

import '../../../provider/provider.dart';
import '../../setting/setting.dart';

class GameControllBar extends StatefulWidget {
  const GameControllBar({
    Key? key,
  }) : super(key: key);

  @override
  _GameControllBarState createState() => _GameControllBarState();
}

class _GameControllBarState extends State<GameControllBar>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = const Duration(milliseconds: 400);
  //status of pause/menu button, onExapnd show others options
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

  //play-pause button changes, close remaing overLay
  void _onPlayPauseButtonChange(ref) {
    if (_settingIsPressed = true) {
      _settingIsPressed = false;
    }
    isExpanded = !isExpanded;
    setState(() {});

    if (isExpanded) {
      //* pause the game
      _playPauseButtonController.forward();
      ref.read(gameManagerProvider.notifier).paused();
    } else {
      //* resume the game
      _playPauseButtonController.reverse();
      ref.read(gameManagerProvider.notifier).playing();
      // debugPrint("onControllBar Resume: ${ref.read(gameManagerProvider)}");
    }
  }

  //todo: change icons color
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(.9, -.9),
          child: Consumer(
            builder: (context, ref, child) => Row(
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
                          _settingIsPressed = !_settingIsPressed;
                          setState(() {});
                        },
                        child: AnimatedScale(
                          duration: animationDuration,
                          alignment: Alignment.center,
                          scale: _settingIsPressed ? 1.25 : 1,
                          child: Icon(
                            Icons.settings,
                            color:
                                _settingIsPressed ? Colors.blue : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
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
        ),
        Align(
          alignment: Alignment.center,
          child: SettingDialogWidget(
            isOpen: _settingIsPressed,
            onClose: () {
              _settingIsPressed = !_settingIsPressed;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
