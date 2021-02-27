import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spaceCraft/widget/models/particle.dart';

class Explosion extends StatefulWidget {
  final Color color;
  final PVector initPosition;
  static bool isExpl = false;
  static Timer timer;
  Explosion({
    Key key,
    this.color,
    this.initPosition,
  }) : super(key: key);

  @override
  _ExplosionState createState() => _ExplosionState();
}

///`Particles Explosion`
class _ExplosionState extends State<Explosion> {
  var _key = GlobalKey();
  Size _size = Size.zero;
  double heigth = kheigth;
  double width = kwidth;
  double _brustMovement = kbrustMovement;
  int _brustDuarationMili = kbrustDuration; // frameBuilder

  int _amountOfParticle = kamountOfParticle;
  List<Particle> particles = [];

  _getSizes() {
    final RenderBox renderBox = _key.currentContext.findRenderObject();
    final size = renderBox.size;
    // print("Size : ${size}");
    setState(() => _size = size);
    // setState(() => slideSize = size);
  }

  _getPositions() {
    final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
    final position = renderBoxRed.localToGlobal(Offset.zero);
    // print("POSITION of widget: $position ");
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    createParticles();
     Timer.periodic(
        Duration(milliseconds: _brustDuarationMili), frameBuilder);
  }


  _afterLayout(_) {
    _getSizes();
    _getPositions();
  }

  createParticles() {
    //generate particles
    for (int i = 0; i < _amountOfParticle; i++) {
      particles.add(Particle());
    }
  }

  /// TODO:: `just Made for 8 particles for eatch brust`
  frameBuilder(Timer timer) {
    //4 sides
    if (particles[0] != null) particles[0].position.x -= _brustMovement;
    if (particles[1] != null) particles[1].position.x += _brustMovement;
    if (particles[2] != null) particles[2].position.y += _brustMovement;
    if (particles[3] != null) particles[3].position.y -= _brustMovement;

    /// we want something round 😁
    if (particles[4] != null) particles[4].position.x += _brustMovement * .7;
    if (particles[4] != null) particles[4].position.y += _brustMovement * .7;

    if (particles[5] != null) particles[5].position.x -= _brustMovement * .7;
    if (particles[5] != null) particles[5].position.y -= _brustMovement * .7;

    if (particles[6] != null) particles[6].position.x += _brustMovement * .7;
    if (particles[6] != null) particles[6].position.y -= _brustMovement * .7;

    if (particles[7] != null) particles[7].position.x -= _brustMovement * .7;
    if (particles[7] != null) particles[7].position.y += _brustMovement * .7;

    //target the corner particle to stop Timer
    if (particles[4].position.x > 45) {
      // log("Stop and rm particles");
      timer.cancel();
      particles.removeRange(0, _amountOfParticle);
      Explosion.isExpl = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      width: width,
      child: Stack(
        key: _key,
        children: <Widget>[
          ...particles
              .map(
                (pt) => Positioned(
                  top: _size.height / 2 - pt.position.y,
                  right: _size.width / 2 - pt.position.x,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: widget.color),
                    height: pt.radius,
                    width: pt.radius,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
