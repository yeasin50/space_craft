import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/utils/paints/paints.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: _testPaint(),
      ),
    ),
  );
}

class _testPaint extends StatelessWidget {
  const _testPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 240;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          color: Colors.cyanAccent.withOpacity(.3),
          width: size,
          height: size,
          child: CustomPaint(
            size: Size(size, size),
            painter: EnemyAPainter(),
          ),
        ),
      ),
    );
  }
}
