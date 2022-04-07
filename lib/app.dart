import 'package:flutter/material.dart';

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
      home: ShipMovemntTest(),
      // home: const StartScreen(),
    );
  }
}
