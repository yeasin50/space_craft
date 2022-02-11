import 'package:flutter/material.dart';

import 'widgetAnimationTest/test_widget.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TestCases(),
      // home: const OnPlayScreen(),
      // home: const StartScreen(),
    );
  }
}
