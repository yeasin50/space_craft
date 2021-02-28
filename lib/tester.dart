import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/GameManager/uiManager.dart';

import 'package:spaceCraft/configs/size.dart';
import 'package:spaceCraft/widget/models/bullet.dart';
import 'package:spaceCraft/widget/models/particle.dart';
import 'package:spaceCraft/widget/rives/rive_explosion1.dart';

class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

//FIXMED:: clear rive by extending and size/scale 0
class _TesterState extends State<Tester> with TickerProviderStateMixin {
  List<ExplosionManager> explosions = [];

  void _updateSize(PVector position) async {
    Provider.of<UIManager>(context, listen: false)
        .addExplosion(ExplosionType.neonBrust, position);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<UIManager>(
        builder: (ctx, data, child) => GestureDetector(
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

                  Positioned(
                    top: 100,
                    child: Container(
                      width: 100,
                      height: 100,
                      child: RiveExplosion1(23),
                    ),
                  ),
                  //Explosions

                  ///TODO:: on Explosion UI gets laggy
                  /// `Single Explosion bug handler`
                  /// Im changing rive to use explosion on game startUP UI
                  if (data.handleExpolosionBug)
                    Positioned(
                      left: data.explosionBug.initPoss.x - 100,
                      top: data.explosionBug.initPoss.y - 100,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: RiveExplosion1(2),
                      ),
                    ),

                  ...data.explosion
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
            ));
  }
}
