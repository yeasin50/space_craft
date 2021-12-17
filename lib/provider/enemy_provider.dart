import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../constants/constants.dart';
import '../model/model.dart';
import 'provider.dart';

final enemyProvider =
    ChangeNotifierProvider.family<EnemyChangeNotifier, BoxConstraints>(
  (ref, constranits) {
    final Size screenSize = Size(
      constranits.maxWidth,
      constranits.maxHeight,
    );

    final GameMode gameMode = ref.watch(gameManagerProvider);
    final GameManager gameModeNofitifer =
        ref.watch(gameManagerProvider.notifier);

    return EnemyChangeNotifier(
      screenSize: screenSize,
      gameMode: gameMode,
    );
  },
);

class EnemyChangeNotifier extends ChangeNotifier {
  // screen size to control enemy movement
  final Size screenSize;

  //enemy generation on different x position
  final Random _random = Random();

  final Duration enemyMovementRate = const Duration(milliseconds: 100);
  final Duration enemyGenerateDuration = const Duration(seconds: 1);
  Timer? _timerEnemyGeneration;

  final double enemyMovementPX = 10.0;

  final gameMode;

  //todo: controll flow
  EnemyChangeNotifier({
    required this.screenSize,
    required this.gameMode,
  }) {
    debugPrint(gameMode.toString());
    _enemyMovement();
    if (gameMode == GameMode.playing) {
      generateEnemies();
    } else {
      if (_timerEnemyGeneration != null) {
        _timerEnemyGeneration!.cancel();
      }
    }
  }

  final List<EnemyShip> _enemies = [];
  List<EnemyShip> get enemies => _enemies;

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
          dX: _random.nextDouble() * screenSize.width,
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

        if (e.position2d.dY > screenSize.height) {
          _enemies.remove(e);
        }
      }
      // debugPrint("f1PY: ${_enemies.first.position2d.dY} ");
      // debugPrint("total enemyShip: ${_enemies.length}");
      notifyListeners();
    });
  }
}
