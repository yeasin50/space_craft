import 'package:flutter/material.dart';
import 'package:space_craft/core/package/magic_ball/magic_ball.dart';

import '../../core/package/glitch_effect/glitch_effect.dart';
import '../home/home.dart';
import '../home/home_page.dart';

//FIXME: [AnimatedMagicBall] wrapper restart the animation
class ParentGlitchTest extends StatelessWidget {
  const ParentGlitchTest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlitchController overlayGlitchController = GlitchController();

    bool enf = false;

    return Scaffold(
      body: SizedBox(
        width: 222,
        height: 200,
        child: GlitchEffect(
          controller: overlayGlitchController,
          child: GestureDetector(
            onTap: () {
              overlayGlitchController.forward();
            },
            child: const MagicBall(
              key: ValueKey("MagicBall widget key"),
              size: 222,
            ),
          ),
        ),
      ),
    );
  }
}
