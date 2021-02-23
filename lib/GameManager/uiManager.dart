import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:spaceCraft/widget/models/bullet.dart';
import 'package:spaceCraft/widget/models/player.dart';

///TODO:: test it
class UIManager with ChangeNotifier {
  ///`Max Storage`
  final _maxPlayerBullet = 20;
  final _maxEnemyBullets = 40;
  final _maxEnemyStore = 14;

  List<Player> _enemies = [];
  List<Bullet> _enemyBullets = [];

  List<Bullet> _playerBullets = [];

  get maxPlayerBullet => _maxPlayerBullet;
  get maxEnemyBullet => _maxEnemyBullets;
  get maxEnemySize => _maxEnemyStore;

  get enemies => _enemies;
  get enemyBullets => _enemyBullets;
  get playerBullets => _playerBullets;

  Future<void> addEnemy(Player enemy) async {
    _enemies.add(enemy);
    print(_enemies.length);
    notifyListeners();
  }

  remEnemy(Player enemy, [int removeRange = 0]) async {
    if (removeRange > 0) {
      _enemies.removeRange(0, _maxEnemyStore ~/ 2);
    } else
      _enemies.remove(enemy);
    notifyListeners();
  }

  Future<void> addEnemyBullet(Bullet bullet) async {
    _enemyBullets.add(bullet);
    notifyListeners();
  }

  remEnemyBullet(Bullet b, {int range = 0}) {
    if (range == 0)
      _enemyBullets.remove(b);
    else {
      _enemyBullets.removeRange(0, _maxEnemyBullets ~/ 2);
    }

    notifyListeners();
  }

  Future<void> addPlayerBullet(Bullet bullet) async {
    _playerBullets.add(bullet);
    notifyListeners();
    log(_playerBullets.length.toString());
  }

  remPlayerBullet({Bullet b, int range = 0}) async {
    if (range == 0)
      _playerBullets.remove(b);
    else {
      _playerBullets.removeRange(0, _playerBullets.length ~/ 2);
    }
    notifyListeners();
  }

  ///Update player bullet poss
  updatePlayerBulletPoss() async {
    _playerBullets = _playerBullets.forEach((element) {
      element.position.y += 1;
    }) as List;
  }
}
