import 'package:flutter/material.dart';
import 'package:space_craft/screens/start/start.screen.dart';

import 'package:space_craft/utils/utils.dart';
import 'package:space_craft/widget/magic_ball.dart';

import 'screens/on_play/on_play.dart';
import 'screens/on_play/on_play.screen.dart';
import 'screens/on_play/widgets/widgets.dart';
import 'utils/ring_path.dart';

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
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Slider(
            value: sliderVal,
            max: 250,
            onChanged: (value) {
              debugPrint("slider value $value");
              setState(() {
                sliderVal = value;
              });
            },
          ),
          Container(
            color: Colors.cyanAccent.withOpacity(.3),
            child: ClipPath(
              clipper: RingPath(),
              child: Container(
                color: Colors.amber,
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
