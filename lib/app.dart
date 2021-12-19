import 'package:flutter/material.dart';

import 'screens/on_play/on_play.screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnPlayScreen(),
    );
  }
}
