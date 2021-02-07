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
import 'package:spaceCraft/widget/rive_player.dart';

import 'widget/models/demo.dart';

class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> with TickerProviderStateMixin {
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

  double _size;
  bool _large = true;
  double maxSize;
  double minSize;

  void _updateSize() {
    setState(() {
      _large = !_large;
      _size = _large ? maxSize : minSize;
    });
  }

  @override
  void initState() {
    super.initState();

    log("refreshed..");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      maxSize = getProportionateScreenWidth(400.0);
      minSize = getProportionateScreenWidth(150.0);
      _size = maxSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black,
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: AnimatedSize(
            curve: Curves.easeInOutBack,
            duration: Duration(seconds: 1),
            vsync: this,
            child: Container(
              width: _size,
              height: _size,
              child: AspectRatio(
                aspectRatio: 1,
                child: PlayerRive(),
              ),
            ),
          ),
        ),
        RaisedButton(
          onPressed: _updateSize,
          child: Text("Update"),
        ),
        ...explosions
            .map(
              (exp) => Positioned(
                top: exp.initPosition.y,
                right: exp.initPosition.x,
                child: exp,
              ),
            )
            .toList(),
      ],
    );
  }
}
