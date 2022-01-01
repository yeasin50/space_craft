import 'package:flutter/material.dart';
import 'package:space_craft/widget/magic_ball.dart';

import 'screens/on_play/on_play.screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _TestCases(),
      //  OnPlayScreen(),
    );
  }
}

class _TestCases extends StatelessWidget {
  const _TestCases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.cyanAccent.withOpacity(.2),
        child: Stack(
          children: [
            ParticleWidget(
              debugMode: true,
              callback: (id) {},
              id: 2,
              parentSize: const Size(100, 100),
            ),
          ],
        ),
      ),
    );
  }
}
