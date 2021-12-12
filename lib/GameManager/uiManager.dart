import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../widget/models/bullet.dart';
import '../widget/models/particle.dart';
import '../widget/models/player.dart';

enum ExplosionType { rounded, neonBrust }

//It would be better to call this Explosion
int exid = 1;

class ExplosionManager {
  final id;
  final PVector initPoss;
  final Widget child;
  bool isRunnig = false;
  ExplosionManager(this.id, this.initPoss, this.child);
}

///TODO:: test it
class UIManager with ChangeNotifier {
  ///`Max Storage`
  final _maxPlayerBullet = 20;
  final _maxEnemyBullets = 40;
  final _maxEnemyStore = 14;

  int _maxExplosionOnStorage = 3;

  List<ExplosionManager> _explosions = [];

  List<Player> _enemies = [];
  List<Bullet> _enemyBullets = [];
  List<Bullet> _playerBullets = [];

  var _handleExplosionBug = false;
  ExplosionManager? explosionBug;

  get handleExpolosionBug => _handleExplosionBug;

  // get maxPlayerBullet => _maxPlayerBullet;
  // get maxEnemyBullet => _maxEnemyBullets;
  // get maxEnemySize => _maxEnemyStore;

  get enemies => _enemies;
  get enemyBullets => _enemyBullets;
  get playerBullets => _playerBullets;
  get explosion => _explosions;

  //Check if already Running
  // we need to set runnable=flase while it's already running or completed the cycle
  // we have already assign same id to ExplosionManager(Explosion) and RiveWidget.
  runTimeExplosionChecker({int? widgetId}) {
    // _explosions.where((element) => widgetId == element.id);
    // or letme check if both are same and perform.
    _explosions.forEach((element) {
      if (element.id == widgetId) {
        element.isRunnig = true;
        // notifyListeners();
      }
    });
  }

  Future<void> addEnemy(Player enemy) async {
    if (_enemies.length > _maxEnemyStore)
      _enemies.removeRange(0, _maxEnemyStore ~/ 2);

    _enemies.add(enemy);
    print(_enemies.length);
    notifyListeners();
  }

  remEnemy({Player? enemy, int removeRange = 0, required List<Player> enemies}) async {
    if (removeRange > 0) _enemies.removeRange(0, _maxEnemyStore ~/ 2);

    if (removeRange > 0) _enemies.remove(enemy);

    if (enemies.length > 0)
      _enemies.removeWhere((element) => enemies.contains(element));

    notifyListeners();
  }

  remEnemyBullet({Bullet? b, int range = 0, required List<Bullet> bullets}) {
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

  remPlayerBullet({Bullet? b, int range = 0, List<Bullet>? bullets}) async {
    if (range == 0)
      _playerBullets.remove(b);
    else if (range != 0) {
      _playerBullets.removeRange(0, _playerBullets.length ~/ 2);
    } else if (bullets!.length > 0) {
      _playerBullets.removeWhere((bl) => bullets.contains(bl));
    }
    notifyListeners();
  }

  ///`Explosion Rives`
  ///we will clear list if length>=3,
  ///then add a single rive to the list and show on UI
  /// but the problem is Rive(4th) doesnt show up after clearing the list

  Future<void> addExplosion(ExplosionType type, PVector pos) async {}

  ///`Not working, remove completed Animation`, text1
  removeAnimation() {
    List<ExplosionManager> tempList = [];
    _explosions.forEach((element) {
      if (element.isRunnig) tempList.add(element);
    });

    _explosions.removeWhere((element) => tempList.contains(element));
  }
}
