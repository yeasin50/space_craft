import 'dart:developer';

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
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MagicBall(),
            AnimatedMagicBall(
              maxSize: 200,
              onEnd: (controller) {
                log("animation ended");
              },
            ),
            const MagicBall.singleBlast(),
            const MagicBall(
              blastDelay: Duration(seconds: 1),
              numberOfParticles: 33,
              child: Align(
                child: Text(
                  "Custom",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
