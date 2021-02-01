import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/widget/headerLive.dart';
import 'package:spaceCraft/widget/headerScore.dart';
import 'package:spaceCraft/widget/health_meter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            HeaderScore(),
            HealthMeter(),
            HeaderLive(),
          ],
        ),
        RaisedButton(
          onPressed: addScore,
          child: Text("Add Score"),
        ),
        RaisedButton(
          onPressed: minScore,
          child: Text("del Score"),
        ),
        RaisedButton(
          onPressed: addLive,
          child: Text("Add live"),
        ),
        RaisedButton(
          onPressed: rmLive,
          child: Text("rm live"),
        ),
         RaisedButton(
          onPressed: addHealth,
          child: Text("add health"),
        )
      ],
    );
  }
}
