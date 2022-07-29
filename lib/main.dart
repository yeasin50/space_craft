import 'dart:async';

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

class _testPaint extends StatefulWidget {
  const _testPaint({Key? key}) : super(key: key);

  @override
  State<_testPaint> createState() => _testPaintState();
}

class _testPaintState extends State<_testPaint>
    with SingleTickerProviderStateMixin {
  final double size = 240;

  Timer? timer;

  int counter = 0;

  late AnimationController controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200))
        ..addListener(() {
          setState(() {});
        });

  late Animation<double> animation =
      Tween<double>(begin: .4, end: 1).animate(controller);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(milliseconds: 70),
      (timer) {
        counter++;

        setState(() {});
      },
    );
  }

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
              width: size,
              height: size,
              child: CustomPaint(
                size: Size(size, size),
                painter: EnemyAPainter(
                  tickTheBool: counter.isEven,
                  fireFromMouth: animation.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
