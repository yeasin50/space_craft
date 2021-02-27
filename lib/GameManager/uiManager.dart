import 'dart:async';
import 'dart:developer' as dbg;

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

  // get maxPlayerBullet => _maxPlayerBullet;
  // get maxEnemyBullet => _maxEnemyBullets;
  // get maxEnemySize => _maxEnemyStore;

  get enemies => _enemies;
  get enemyBullets => _enemyBullets;
  get playerBullets => _playerBullets;

  Future<void> addEnemy(Player enemy) async {
    if (_enemies.length > _maxEnemyStore)
      _enemies.removeRange(0, _maxEnemyStore ~/ 2);

    _enemies.add(enemy);
    print(_enemies.length);
    notifyListeners();
  }

  remEnemy({Player enemy, int removeRange = 0, List<Player> enemies}) async {
    if (removeRange > 0) _enemies.removeRange(0, _maxEnemyStore ~/ 2);

    if (removeRange > 0) _enemies.remove(enemy);

    if (enemies.length > 0)
      _enemies.removeWhere((element) => enemies.contains(element));

    notifyListeners();
  }

  // Future<void> addEnemyBullet(Bullet bullet) async {
  //   _enemyBullets.add(bullet);
  // }

  remEnemyBullet({Bullet b, int range = 0, List<Bullet> bullets}) {
    if (range == 0) _enemyBullets.remove(b);
    if (range > 0) {
      _enemyBullets.removeRange(0, _maxEnemyBullets ~/ 2);
    }
    if (bullets.length > 0)
      _enemyBullets.removeWhere((element) => bullets.contains(element));

    notifyListeners();
  }

  Future<void> addPlayerBullet(Bullet bullet) async {
    _playerBullets.add(bullet);
    notifyListeners();
    // dbg.log(_playerBullets.length.toString());
  }

  Future<void> addEnemyBullet(Bullet bullet) async {
    _enemyBullets.add(bullet);
    notifyListeners();
    // dbg.log(_enemyBullets.length.toString());
  }

  remPlayerBullet({Bullet b, int range = 0, List<Bullet> bullets}) async {
    if (range == 0)
      _playerBullets.remove(b);
    else if (range != 0) {
      _playerBullets.removeRange(0, _playerBullets.length ~/ 2);
    } else if (bullets.length > 0) {
      _playerBullets.removeWhere((bl) => bullets.contains(bl));
    }
    notifyListeners();
  }
}
