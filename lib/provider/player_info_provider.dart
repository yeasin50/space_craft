import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model.dart';

final playerInfoProvider = ChangeNotifierProvider<PlayerInfoNotifier>(
  (ref) {
    return PlayerInfoNotifier();
  },
);

///this provide Player UI update info
class PlayerInfoNotifier extends ChangeNotifier {
  /// create player instance
  Player player = Player();

  final Duration bulletGenerateRate = const Duration(milliseconds: 100);

  //todo: try without CancelableOperation
  List<Bullet> bullets = [];
  CancelableOperation? _cancelableOperation;
  late Timer _timer;

  /// update player vertical position
  void updateTopPosition(double dY) {
    player.position2d.dY = dY;
    notifyListeners();
  }

  ///update player horizontal position
  void updateLeftPosition(double dX) {
    player.position2d.dX = dX;
    notifyListeners();
  }

  void startShooting() {
    player.shoot = true;
    _bulletGeneration();
  }

  void stopShooting() {
    player.shoot = false;
    _cancelableOperation!.cancel();
    _timer.cancel();
    notifyListeners();
  }

  _bulletGeneration() {
    if (_cancelableOperation != null) {
      _cancelableOperation!.cancel();
    }

    _cancelableOperation = CancelableOperation.fromFuture(
      Future.delayed(bulletGenerateRate),
    ).then((p0) {
      _timer = Timer.periodic(bulletGenerateRate, (timer) {
        _addBullet();
      });
    }, onCancel: () {
      _timer.cancel();
    });
  }

  _addBullet() {
    bullets.add(Bullet(
      position: Vector2.fromValue(player.position2d),
    ));

    notifyListeners();
  }

  /// increment score of player by destroying enemies
  void incrementScore() {
    // player._score += 1;
    notifyListeners();
  }
}
