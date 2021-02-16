import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';


///`Neon Brust`
class RiveExplosion2 extends StatefulWidget {
  RiveExplosion2({Key key}) : super(key: key);

  @override
  _RiveExplosion2State createState() => _RiveExplosion2State();
}

class _RiveExplosion2State extends State<RiveExplosion2> {
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/rive/explosion(brust).riv").then((data) async {
      final file = RiveFile();
      if (file.import(data)) {
        final artboard = file.mainArtboard;
        artboard.addController(_controller = SimpleAnimation("brust"));
        setState(() {
          _riveArtboard = artboard;
        });
      }
    });
    log("Importing Explosion2.....");
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
