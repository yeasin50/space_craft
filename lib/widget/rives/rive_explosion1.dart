import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveExplosion1 extends StatefulWidget {
  RiveExplosion1({Key key}) : super(key: key);

  @override
  _RiveExplosion1State createState() => _RiveExplosion1State();
}

class _RiveExplosion1State extends State<RiveExplosion1>
    with SingleTickerProviderStateMixin {
      
  RiveAnimationController _controller;
  Artboard _riveArtboard;

  bool get isPlaying => _controller?.isActive ?? false;

  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/rive/explosion1.riv").then((data) async {
      final file = RiveFile();
      if (file.import(data)) {
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation("brust"));
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });
    log("Importing Explosion1.....");
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? SizedBox()
        : Rive(
            artboard: _riveArtboard,
          );
  }
}
