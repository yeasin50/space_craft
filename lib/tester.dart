import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/configs/size.dart';
import 'package:spaceCraft/widget/explosion.dart';
import 'package:spaceCraft/widget/headerLive.dart';
import 'package:spaceCraft/widget/headerScore.dart';
import 'package:spaceCraft/widget/health_meter.dart';
import 'package:spaceCraft/widget/models/particle.dart';
import 'package:spaceCraft/widget/rives/rive_explosion1.dart';
import 'package:spaceCraft/widget/rives/rive_explosion2.dart';
import 'package:spaceCraft/widget/rives/rive_player.dart';

import 'widget/models/demo.dart';

class ExplosionManager {
  PVector initPoss;
  Widget child;
  ExplosionManager(this.initPoss, this.child);
}

class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

//FIXME:: clear rive
class _TesterState extends State<Tester> with TickerProviderStateMixin {
  List<ExplosionManager> explosions = [];


  void _updateSize(PVector position) {
    setState(() {
      explosions.add(ExplosionManager(position, RiveExplosion1()));
    });
    if (explosions.length > 5) {
      setState(() {
        explosions.removeRange(0, 2);
      });
    }

    log(explosions.length.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return GestureDetector(
      onPanDown: (details) {
        var posX = details.globalPosition.dx;
        var posY = details.globalPosition.dy;
        _updateSize(PVector(posX, posY));
      },
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
          ),

          //Explosions
          ...explosions
              .map(
                (e) => Positioned(
                  top: e.initPoss.y - 100,
                  left: e.initPoss.x - 100,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: e.child,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
