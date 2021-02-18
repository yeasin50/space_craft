import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';

import 'package:spaceCraft/configs/size.dart';
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
    Provider.of<PlayerManager>(context, listen: false)
        .addExplosion(ExplosionType.neonBrust, position);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<PlayerManager>(
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
                      child: RiveExplosion1(),
                    ),
                  ),
                  //Explosions

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

                  //Explosion Bugs Handling
                  if (data.handleExpolosionBug)
                    Positioned(
                      left: data.explosionBug.initPoss.x - 100,
                      top: data.explosionBug.initPoss.y - 100,
                      child: Container(
                        width: 200,
                        height: 200,
                        child: RiveExplosion1(),
                      ),
                    )
                ],
              ),
            ));
  }
}
