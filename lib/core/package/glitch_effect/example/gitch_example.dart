import 'package:flutter/material.dart';

import '../glitch_effect.dart';

class GlitchExample extends StatefulWidget {
  const GlitchExample({Key? key}) : super(key: key);

  @override
  State<GlitchExample> createState() => _GlitchExampleState();
}

class _GlitchExampleState extends State<GlitchExample> {
  GlitchController glitchController = GlitchController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlitchEffect(
              controller: glitchController,
              child: const Text("single Glitch effect Text"),
            ),
            ElevatedButton(
              onPressed: () {
                glitchController.forward();
              },
              child: const Text("replay"),
            ),
            const SizedBox(height: 24),
            GlitchEffect(
              controller: GlitchController(
                repeatDelay: const Duration(seconds: 2),
              ),
              child: Container(
                height: 250,
                width: 250,
                alignment: Alignment.center,
                color: Colors.green,
                child: const Text(
                  "GlitchContainer",
                  style: TextStyle(
                    fontSize: 33,
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
