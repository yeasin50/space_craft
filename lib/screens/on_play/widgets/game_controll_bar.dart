import 'package:flutter/material.dart';

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
                    children: [
                      IconButton(
                        onPressed: () {
                          _settingIsPressed = !_settingIsPressed;
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                controllButton(ref),
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

//controll button, always
  IconButton controllButton(WidgetRef ref) {
    return IconButton(
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
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
      },
      icon: AnimatedIcon(
        color: Colors.white,
        icon: AnimatedIcons.pause_play, // may changes later
        progress: _playPauseButtonController,
      ),
    );
  }
}
