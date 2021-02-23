import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:spaceCraft/widget/explosion.dart';
import 'package:spaceCraft/widget/models/particle.dart';
import 'package:spaceCraft/widget/rives/rive_explosion1.dart';
import 'package:spaceCraft/widget/rives/rive_explosion2.dart';

enum DamageOnCollision {
  bullet,
  ship,
}

enum ExplosionType { rounded, neonBrust }

class ExplosionManager {
  PVector initPoss;
  Widget child;
  ExplosionManager(this.initPoss, this.child);
}

class PlayerManager with ChangeNotifier {
  int _score = 0;
  int _health = 80;
  int _live = 2;
  int _maxLive = 3;
  int _maxExplosionOnStorage = 3;

  final _shipPerDestroy = 1;
  final _bossShipDestroy = 5;

  final _damagePerBullet = 10;
  final _damagePerShip = 30;

  final List<ExplosionManager> _explosions = [];
  var _handleExplosionBug = false;
  ExplosionManager explosionBug;

  get handleExpolosionBug => _handleExplosionBug;
  get score => _score;
  get health => _health;
  get live => _live;
  get maxLive => _maxLive;
  get explosion => _explosions;

  explosionBugs() {}

  Future<void> addExplosion(ExplosionType type, PVector pos) async {
    var widget =
        type == ExplosionType.neonBrust ? RiveExplosion2() : RiveExplosion1();

    if (_explosions.length >= _maxExplosionOnStorage) {
      print("Overule");
      _explosions.clear();
      _handleExplosionBug = true;
      explosionBug = ExplosionManager(pos, RiveExplosion2());
    } else {
      _handleExplosionBug = false;

      _explosions.add(ExplosionManager(pos, widget));
    }

    log(_explosions.length.toString());
    notifyListeners();
  }

  // startGame() {
  //   _isPlaying = true;
  //   notifyListeners();
  // }

  // stopGame() {
  //   _isPlaying = false;
  //   notifyListeners();
  // }

  //Normal ship destroy
  //FIXME:: fixe score update
  incrementScore() {
    _score += _shipPerDestroy;
    log(_score.toString());
    notifyListeners();
  }

  decrementScore() {
    _score -= _shipPerDestroy;
    notifyListeners();
  }

  increaseLive() {
    _live += 1;
    notifyListeners();
  }

  increaseHealth() {
    _health += 1;
    if (_health > 100 && _live < _maxLive) {
      _live += 1;
      _health = 0;
    }
    log(" health: ${_health.toString()}");
    notifyListeners();
  }

  // Player Damage handler
  damageHealth(DamageOnCollision dmgCol) {
    if (dmgCol == DamageOnCollision.bullet)
      _health -= _damagePerBullet;
    else if (dmgCol == DamageOnCollision.ship) _health -= _damagePerShip;

    if (_health < 0) {
      _live -= 1;
      _health = 100;
    }
    notifyListeners();
  }
}
