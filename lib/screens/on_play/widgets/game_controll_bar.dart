import 'package:flutter/material.dart';
import 'package:space_craft/provider/provider.dart';

class GameControllBar extends StatefulWidget {
  const GameControllBar({Key? key}) : super(key: key);

  @override
  _GameControllBarState createState() => _GameControllBarState();
}

class _GameControllBarState extends State<GameControllBar>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = const Duration(milliseconds: 400);
  //status of pause/menu button, onExapnd show others options
  bool isExpanded = false;
  late AnimationController controller;

  _initAnimation() {
    controller = AnimationController(
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
                  ...List.generate(
                    2,
                    (index) => IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.alarm),
                    ),
                  )
                ],
              ),
            ),
            controllButton(ref),
          ],
        ),
      ),
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
          controller.forward();

          ref.read(enemyProvider).pauseMode();
        } else {
          controller.reverse();
          ref.read(enemyProvider).generateEnemies();
        }
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.pause_play, // may changes later
        progress: controller,
      ),
    );
  }
}
