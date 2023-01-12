import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neon_ring/neon_ring.dart';

void main() {
  runApp(const MaterialApp(
    home: NeonRingExample(),
  ));
}

class NeonRingExample extends StatelessWidget {
  const NeonRingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (_, constraints) => Column(
          children: [
            NeonRingWidget(
              data: NeonCircleData(
                size: min(constraints.maxWidth, constraints.maxHeight) / 3,
              ),
            ),
            NeonRingWidget(
              data: NeonCircleData(
                size: min(constraints.maxWidth, constraints.maxHeight) / 3,
                colorBlink: true,
                rotatable: true,
                rotationIncrementRateByDegree: .1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
