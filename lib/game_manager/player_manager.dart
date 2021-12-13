import 'package:flutter/material.dart';

enum DamageOnCollision {
  bullet,
  ship,
}

class PlayerManager with ChangeNotifier {
  int _score = 0;
  int _health = 80;
  int _live = 2;
  final int _maxLive = 3;

  final _shipPerDestroy = 1;

  final _damagePerBullet = 10;
  final _damagePerShip = 30;

  get score => _score;
  get health => _health;
  get live => _live;
  get maxLive => _maxLive;

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
    // log(_score.toString());
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
    // log(" health: ${_health.toString()}");
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
