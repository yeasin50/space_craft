import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:space_craft/feature/start/start.dart';

import 'feature/on_play/on_play.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: kProfileMode,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        textTheme: Theme.of(context).textTheme.copyWith(),
      ),
      // home: const TestCases(),
      home: const StartScreen(),
      // home: const StartScreen(),
    );
  }
}
