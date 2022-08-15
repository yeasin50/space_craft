// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';

import '../core/entities/entities.dart';
import '../feature/on_play/models/models.dart';
import '../feature/on_play/utils/utils.dart';
 
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

  bool isXState = false;
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
                child: const Text("Change State")),
            ElevatedButton(
                onPressed: () {
                  controller.forward();
                },
                child: const Text("start")),
            ElevatedButton(
                onPressed: () {
                  controller.reverse();
                },
                child: const Text("reverse")),
            Container(
              // color: Colors.cyanAccent.withOpacity(.3),
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              width: Matrix8x12.col * size,
              height: Matrix8x12.row * size,
              child: CustomPaint(
                size: Size(size, size),
                painter: InvaderPaintA(
                  invaderMatrix: isXState
                      ? InvaderMatrixC().xState
                      : InvaderMatrixC().yState,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
