import 'package:flutter/material.dart';

import 'screens/screens.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        textTheme: Theme.of(context).textTheme.copyWith(),
      ),
      // home: const TestCases(),
      home: const SettingPage(),
      // home: const StartScreen(),
    );
  }
}
