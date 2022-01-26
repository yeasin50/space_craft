import 'package:flutter/material.dart';
import 'package:space_craft/constants/color_palette.dart';
import 'package:space_craft/screens/start/start_screen.dart';

import 'package:space_craft/utils/utils.dart';
import 'package:space_craft/widget/magic_ball.dart';

import 'screens/on_play/on_play.dart';
import 'screens/on_play/on_play.screen.dart';
import 'screens/on_play/widgets/widgets.dart';
import 'utils/ring_path.dart';
import 'widget/neon_ring.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      // home: const _TestCases(),
      // home: OnPlayScreen(),
      home: const StartScreen(),
    );
  }
}

class _TestCases extends StatefulWidget {
  const _TestCases({Key? key}) : super(key: key);

  @override
  State<_TestCases> createState() => _TestCasesState();
}

class _TestCasesState extends State<_TestCases> {
  double sliderVal = .2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: .3,
                  child: NeonRignWidget(
                    key: UniqueKey(),
                    colorSet: colorSet0,
                    rotation: true,
                    radius: 165,
                    rotationIncrementRate: 10,
                    duration: const Duration(milliseconds: 50),
                    frameThickness: 16,
                  ),
                ),
                NeonRignWidget(
                  key: UniqueKey(),
                  colorSet: colorSet0,
                  rotation: true,
                  rotationIncrementRate: 10,
                  radius: 155,
                  duration: const Duration(milliseconds: 50),
                  frameThickness: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
