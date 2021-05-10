import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/configs/size.dart';

class PlayerRive extends StatefulWidget {
  PlayerRive({Key key}) : super(key: key);

  @override
  _PlayerRiveState createState() => _PlayerRiveState();
}

class _PlayerRiveState extends State<PlayerRive>
    with SingleTickerProviderStateMixin {
  ///animation OnOFF
  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

 
  Artboard _riveArtboard;
  RiveAnimationController _controller;


  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/rive/aircraft.riv").then((data) async {
          final file = RiveFile.import(data);
        final artboard = file.artboardByName("shipBoard");
        artboard.addController(_controller = SimpleAnimation("playing"));
        setState(() {
          _riveArtboard = artboard;
        });
      
    });
    // log("Importing ship.....");
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
