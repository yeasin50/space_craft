import 'package:flutter/material.dart';
import 'package:space_craft/constants/color_palette.dart';
import 'package:space_craft/screens/start/start.screen.dart';

import 'package:space_craft/utils/utils.dart';
import 'package:space_craft/widget/magic_ball.dart';

import 'screens/on_play/on_play.dart';
import 'screens/on_play/on_play.screen.dart';
import 'screens/on_play/widgets/widgets.dart';
import 'utils/ring_path.dart';
import 'widget/neon_rign.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const _TestCases(),
      // home: OnPlayScreen(),
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
                  child: NeonRingWidget(
                    key: UniqueKey(),
                    colorSet: colorSet0,
                    rotation: true,
                    radius: 165,
                    rotationIncrementRate: 10,
                    duration: Duration(milliseconds: 50),
                    frameThickness: 16,
                  ),
                ),
                NeonRingWidget(
                  key: UniqueKey(),
                  colorSet: colorSet0,
                  rotation: false,
                  rotationIncrementRate: 10,
                  radius: 155,
                  duration: Duration(milliseconds: 50),
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
