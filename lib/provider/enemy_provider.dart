import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../model/model.dart';
import 'provider.dart';

final enemyProvider = ChangeNotifierProvider<EnemyChangeNotifier>(
  (ref) {
    return EnemyChangeNotifier();
  },
);

class EnemyChangeNotifier extends ChangeNotifier {
  // screen size to control enemy movement
  Size? _screenSize = Size.zero;

  EnemyChangeNotifier() {
    _enemyMovement();
  }

  //enemy generation on different x position
  final Random _random = Random();

  final Duration enemyMovementRate = const Duration(milliseconds: 100);
  final Duration enemyGenerateDuration = const Duration(seconds: 1);
  Timer? _timerEnemyGeneration;

  final double enemyMovementPX = 10.0;

  final List<EnemyShip> _enemies = [];
  List<EnemyShip> get enemies => _enemies;

  initScreen({required Size screenSize}) {
    Future.delayed(Duration.zero).then((value) {
      // dirty way of handling errors 🤐
      _screenSize = screenSize;
      notifyListeners();
    });
  }

  generateEnemies() {
    //todo: create handler
    _timerEnemyGeneration = Timer.periodic(enemyGenerateDuration, (t) {
      _addEnemy();
    });
  }

  // create enemyShip on (,0) possition
  _addEnemy() {
    _enemies.add(
      EnemyShip(
        position2d: Vector2(
          dX: _random.nextDouble() * _screenSize!.width,
          dY: 0.0,
        ),
      ),
    );
    notifyListeners();
  }

  // move downward and destroy while it is downSide:enemyShip
  _enemyMovement() {
    Timer.periodic(enemyMovementRate, (timer) {
      if (_enemies.isEmpty) return;

      for (final e in _enemies) {
        e.position2d.dY += enemyMovementPX;

        if (e.position2d.dY > _screenSize!.height) {
          _enemies.remove(e);
        }
      }
      // debugPrint("f1PY: ${_enemies.first.position2d.dY} ");
      // debugPrint("total enemyShip: ${_enemies.length}");
      notifyListeners();
    });
  }
}
