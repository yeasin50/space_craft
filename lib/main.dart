import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/entities/entities.dart';
import 'feature/on_play/models/models.dart';
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

  bool isXState = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  isXState = !isXState;
                  setState(() {});
                },
                child: Text("Change State")),
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
              // color: Colors.cyanAccent.withOpacity(.3),
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              width: Matrix8x12.col * size,
              height: Matrix8x12.row * size,
              child: CustomPaint(
                size: Size(size, size),
                painter: InvaderPaintA(
                  invaderMatrix:
                      isXState ? InvaderMatrixA.x() : InvaderMatrixA.y(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
