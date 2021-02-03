import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/widget/explosion.dart';
import 'package:spaceCraft/widget/headerLive.dart';
import 'package:spaceCraft/widget/headerScore.dart';
import 'package:spaceCraft/widget/health_meter.dart';
import 'package:spaceCraft/widget/models/particle.dart';

import 'widget/models/demo.dart';

class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  addScore() {
    Provider.of<PlayerManager>(context, listen: false).incrementScore();
  }

  minScore() {
    Provider.of<PlayerManager>(context, listen: false).decrementScore();
  }

  addLive() {
    Provider.of<PlayerManager>(context, listen: false).increaseLive();
  }

  rmLive() {
    Provider.of<PlayerManager>(context, listen: false)
        .damageHealth(DamageOnCollision.bullet);
  }

  addHealth() {
    Provider.of<PlayerManager>(context, listen: false).increaseHealth();
  }

  initCollide() {}

  List<Explosion> explosions = [];
  List<Demo> demo = [];

  @override
  void initState() {
    super.initState();
    setState(
      () => demo = [
        Demo(
          text: Text("A"),
          initPosition: PVector(200, 200),
        ),
        Demo(
          text: Text("b"),
          initPosition: PVector(100, 140),
        ),
         Demo(
          text: Text("C"),
          initPosition: PVector(10, 140),
        ),
         Demo(
          text: Text("D"),
          initPosition: PVector(0, 140),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      ...explosions
          .map(
            (exp) => Positioned(
              top: exp.initPosition.y,
              right: exp.initPosition.x,
              child:  exp ,
            ),
          )
          .toList(),
    ]);
  }
}
