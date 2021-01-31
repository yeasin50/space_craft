// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
// import 'package:spaceCraft/player.dart';
// import 'package:spaceCraft/widget/bullet.dart';

// class EnemyProvider extends ChangeNotifier {
//   List<Player> _enemies = [];
//   List<Bullet> _enemyBullets = [];
//   List<Bullet> _playerBullets = [];

//   Future<List<Player>> enemies() async {
//     return _enemies;
//   }

//   Future<void> addEnemy(Player enemy) async {
//     _enemies.add(enemy);
//     notifyListeners();
//   }

//   Future<void> rmEnemy(Player enemy) async {
//     _enemies.remove(enemy);
//     notifyListeners();
//   }

//   Future<List<Bullet>> getEnemyBullets() async {
//     return _enemyBullets;
//   }

//   Future<void> addEBullet(Bullet bullet) {
//     _enemyBullets.add(bullet);
//     notifyListeners();
//   }

//   Future<void> deleteBullet(Bullet bullet) {
//     _enemyBullets.remove(bullet);
//   }

//   Future<List<Bullet>> getPlayerBullets() async {
//     return _playerBullets;
//   }

//   Future<void> addPlayerBullet(Bullet bullet) {
//     _playerBullets.add(bullet);
//     notifyListeners();
//   }

//   Future<void> rmPlayerBullet(Bullet bullet) {
//     _playerBullets.remove(bullet);
//   }
// }
