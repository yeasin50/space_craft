import 'dart:async';

import 'package:flutter/material.dart';
import 'package:space_craft/core/constants/color_palette.dart';
import 'package:space_craft/core/utils/helpers/helpers.dart';

class AnimatedNavigateWidget extends StatefulWidget {
  const AnimatedNavigateWidget({
    super.key,
    this.onTap,
    this.showAnimation = false,
  });

  final VoidCallback? onTap;

  /// show animated arrow, default is false
  final bool showAnimation;

  @override
  State<AnimatedNavigateWidget> createState() => _AnimatedNavigateWidgetState();
}

class _AnimatedNavigateWidgetState extends State<AnimatedNavigateWidget> {
  int numberOfArrow = 7;

  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showAnimation == false
        ? const SizedBox()
        : GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  numberOfArrow,
                  (index) => Transform(
                    transform: Matrix4.identity()
                      ..setEntry(1, 1,
                          timer.tick % numberOfArrow == index + 1 ? .5 : 1)
                      ..setEntry(1, 1,
                          timer.tick % numberOfArrow == index + 2 ? .7 : 1)
                      ..setEntry(
                          3, 3, timer.tick % numberOfArrow == index ? .5 : 1),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: changeColorHue(
                          color: colorSet0.first, increaseBy: 20),
                      shadows: [
                        BoxShadow(
                            color: getRandomColor,
                            offset: const Offset(-1, .1)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
