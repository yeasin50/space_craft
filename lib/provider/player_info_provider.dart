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

  // bullet will move upward by [_bulletSpeed] px
  final double _bulletSpeed = 10.0;

  List<Bullet> get bullets => _bullets;
  List<Bullet> _bullets = [];

  //todo: try without CancelableOperation
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
        _bulletsMovement(); //todo: move to different section

        notifyListeners();
      });
    }, onCancel: () {
      _timer.cancel();
    });
  }

  _addBullet() {
    _bullets.add(Bullet(
      position: Vector2.fromValue(player.position2d)
        ..dX = player.position2d.dX + player.width / 2, //fire from top center
    ));
  }

  _removeBullet(Bullet b) {
    _bullets.remove(b);
  }

  //* player bullets will move up(-Y)
  _bulletsMovement() {
    for (final b in _bullets) {
      b.position.dY -= _bulletSpeed;
      if (b.position.dY < 0) _removeBullet(b);
    }
  }

  /// increment score of player by destroying enemies
  void incrementScore() {
    // player._score += 1;
    notifyListeners();
  }
}
