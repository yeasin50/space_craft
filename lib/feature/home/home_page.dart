import 'package:flutter/material.dart';

import 'start_animation.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
             const StartPageScaler(),
            ],
          );
        },
      ),
    );
  }
}

class StartPageScaler extends StatefulWidget {
  const StartPageScaler({Key? key}) : super(key: key);

  @override
  State<StartPageScaler> createState() => _StartPageScalerState();
}

class _StartPageScalerState extends State<StartPageScaler>
    with SingleTickerProviderStateMixin {
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: opacity,
      child: StartAnimation(
        onAnimationEnd: () {
         setState(() {
            opacity = 0;
         });
        },
      ),
    );
  }
}
