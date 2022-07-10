import 'package:flutter/material.dart';

import '../../core/package/glitch_effect/glitch_effect.dart';
import '../on_play/on_play.screen.dart';
import 'home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StartPageAnimation(),
    );
  }
}

class StartPageAnimation extends StatefulWidget {
  const StartPageAnimation({Key? key}) : super(key: key);

  @override
  State<StartPageAnimation> createState() => _StartPageAnimationState();
}

class _StartPageAnimationState extends State<StartPageAnimation>
    with SingleTickerProviderStateMixin {
  double opacityOfStartAnimation = 1;

  bool endOfStartAnimation = false;
  final GlitchController overlayGlitchController = GlitchController();

  // complete the animation and enable navigation
  void navToOnPlayScreen() async {
    if (!endOfStartAnimation) return;
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacityOfStartAnimation = 0;
      overlayGlitchController.forward();
    });

    // wait to finish glitchEffect
    await Future.delayed(overlayGlitchController.duration * 1.4);

    if (!mounted) return;
    Navigator.of(context).pushNamed(OnPlayScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // full screen glitch
        Positioned.fill(
          child: GlitchEffect(
            controller: overlayGlitchController,
            child: Container(
              color: Colors.black38,
            ),
          ),
        ),

        //* magicBal,playerShip,neon circle
        AnimatedOpacity(
          duration: const Duration(milliseconds: 600),
          opacity: opacityOfStartAnimation,
          child: CentralAnimation(
            onAnimationEnd: () => setState(() => endOfStartAnimation = true),
          ),
        ),

        Align(
          alignment: const Alignment(0, .7),
          child: AnimatedOpacity(
            key: const ValueKey("StartTextAnimation widget"),
            duration: const Duration(milliseconds: 600),
            opacity: endOfStartAnimation ? 1 : 0,
            child: StartTextAnimation(onTap: navToOnPlayScreen),
          ),
        )
      ],
    );
  }
}
