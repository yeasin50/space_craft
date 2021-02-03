import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spaceCraft/widget/models/particle.dart';

class Demo extends StatefulWidget {
  final PVector initPosition;
  final Text text;
  PVector localPos = PVector(0, 0);
  final height = 140.0, width = 140.0;
  Demo({
    Key key,
    this.initPosition,
    this.text,
  }) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 100), frameBuilder);
  }

  frameBuilder(Timer timer) {
    setState(() {
      widget.localPos.x += 10;
      widget.localPos.y += 10;

      if (widget.localPos.x - 10 > widget.height) {
        timer.cancel();
        log("dispose timer ${widget.text.data.toString()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log("render ${widget.text.data.toString()}");
    return Container(
      color: Colors.blue.withOpacity(.3),
      width: widget.width,
      height: widget.height,
      child: Stack(children: [
        Positioned(
          top: widget.localPos.y,
          left: widget.localPos.x,
          child: widget.text,
        )
      ]),
    );
  }
}
