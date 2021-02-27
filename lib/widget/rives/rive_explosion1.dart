import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:spaceCraft/GameManager/uiManager.dart';

class RiveExplosion1 extends StatefulWidget {
  final id;
  RiveExplosion1(this.id);

  @override
  _RiveExplosion1State createState() => _RiveExplosion1State();
}

class _RiveExplosion1State extends State<RiveExplosion1>
    with SingleTickerProviderStateMixin {
  RiveAnimationController _controller;
  Artboard _riveArtboard;

  bool checked = false;

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
    // log("Importing Explosion1.....");
  }

  @override
  Widget build(BuildContext context) {
    if (!checked && isPlaying) {
      Provider.of<UIManager>(context)
          .runTimeExplosionChecker(widgetId: widget.id);
      setState(() => checked = true);
    }
    return _riveArtboard == null
        ? SizedBox()
        : Rive(
            artboard: _riveArtboard,
          );
  }
}
