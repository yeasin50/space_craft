import 'package:flutter/material.dart';
import 'package:space_craft/screens/on_play/on_play.dart';

import 'screens/on_play/ship_test.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      // home: const TestCases(),
      home: const OnPlayScreen(),
      // home: const StartScreen(),
    );
  }
}
