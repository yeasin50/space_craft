import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/entities/entities.dart';
import 'feature/on_play/utils/paints/enemy_ships_paint/enemy_ships_paint.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: _testPaint(),
      ),
    ),
  );
}

class _testPaint extends StatefulWidget {
  const _testPaint({Key? key}) : super(key: key);

  @override
  State<_testPaint> createState() => _testPaintState();
}

class _testPaintState extends State<_testPaint>
    with SingleTickerProviderStateMixin {
  final double size = 25;

  Timer? timer;

  int counter = 0;

  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100))
    ..addListener(() {
      setState(() {});
    })
    ..repeat(reverse: true);

  late Animation<double> animation =
      Tween<double>(begin: 0, end: 1).animate(controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.forward();
                },
                child: Text("start")),
            ElevatedButton(
                onPressed: () {
                  controller.reverse();
                },
                child: Text("reverse")),
            Container(
              color: Colors.cyanAccent.withOpacity(.3),
              width: InvaderMatrix.col * size,
              height: InvaderMatrix.row * size,
              child: CustomPaint(
                size: Size(size, size),
                painter: InvaderPaintA(invaderMatrix: InvaderMatrix.aX),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
