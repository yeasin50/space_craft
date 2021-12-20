import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

import '../../model/model.dart';
import 'provider.dart';

final playerInfoProvider = ChangeNotifierProvider<PlayerInfoNotifier>(
  (ref) {
    return PlayerInfoNotifier();
  },
);

///this provide Player UI update info
class PlayerInfoNotifier extends ChangeNotifier {
  /// create player instance
  final Player player = Player();

  final Duration bulletGenerateRate = const Duration(milliseconds: 100);
  final Duration bulletMovementRate = const Duration(milliseconds: 50);

  // bullet will move upward by [_bulletSpeed] px
  final double _bulletSpeed = 10.0;

  List<Bullet> get bullets => _bullets;
  final List<Bullet> _bullets = [];

  //todo: try without CancelableOperation
  CancelableOperation? _cancelableOperation;
  Timer? _timer;

  //bullet movement  controller
  Timer? _timerBulletMovement;

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
    //can include a bullet just on tap,
    player.shoot = true;
    _bulletGeneration();
  }

  void stopShooting() {
    player.shoot = false;
    _cancelableOperation?.cancel();
    _timer?.cancel();
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
      _bulletsMovement();
    }, onCancel: () {
      _timer?.cancel();

      _timer = null;
    });
  }

  _addBullet() {
    _bullets.add(Bullet(
      position: Vector2.fromValue(player.position2d)
        ..dX =
            player.position2d.dX + player.size.width / 2, //fire from top center
    ));
    notifyListeners();
  }

  //* player bullets will move up(-Y)
  _bulletsMovement() {
    // dont create antoher timer for movement
    if (_timerBulletMovement != null && _timerBulletMovement!.isActive) return;
    _timerBulletMovement = Timer.periodic(
      bulletMovementRate,
      (timer) {
        if (_bullets.isEmpty) return;

        for (final b in _bullets) {
          b.position.dY -= _bulletSpeed;
          if (b.position.dY < 0) _bullets.remove(b);
        }
        debugPrint("bullet length: ${bullets.length}");
        notifyListeners();
      },
    );
  }

  /// increment score of player by destroying enemies
  void incrementScore() {
    // player._score += 1;
    notifyListeners();
  }

//** controllers  */
  /// stop player, bullet,generator
  pauseMode() {
    _timerBulletMovement?.cancel();
  }

  /// start player bullets movement
  payingMode() {
    _bulletsMovement();

    debugPrint("playerProvider: PlayingMode");
    debugPrint("BulletMovement Timer ${_timerBulletMovement == null}");
  }
}
