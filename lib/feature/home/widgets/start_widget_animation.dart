import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_palette.dart';

class StartTextAnimation extends StatelessWidget {
  final VoidCallback onTap;
  const StartTextAnimation({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: true,
      repeatForever: true,
      onTap: onTap,
      animatedTexts: [
        ColorizeAnimatedText(
          'Tap to Start',
          textStyle: TextStyle(fontSize: 33),
          colors: colorSet1,
        ),
      ],
    );
  }
}
