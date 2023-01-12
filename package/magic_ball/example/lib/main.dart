import 'package:flutter/material.dart';
import 'package:magic_ball/magic_ball.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MagicBallExample(),
    );
  }
}

class MagicBallExample extends StatelessWidget {
  const MagicBallExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [const MagicBall()],
      ),
    );
  }
}
