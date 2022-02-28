import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../extensions/extensions.dart';
import '../screens/on_play/utils/utils.dart';
import 'provider.dart';

final playerInfoProvider = ChangeNotifierProvider<PlayerInfoNotifier>(
  (ref) {
    return PlayerInfoNotifier(ref: ref);
  },
);

///this provide Player UI update info
class PlayerInfoNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;

  IPlayerScore scoreManager = PlayerScoreManager();
  IShipHealth shipHealthManager = PlayerHealthManager();

  /// create player instance //todo: pass initPoss
  final Player player = Player(position: Vector2(dX: 100, dY: 100));

  final Duration bulletGenerateRate = const Duration(milliseconds: 400);
  final Duration bulletMovementRate = const Duration(milliseconds: 50);

  // bullet will move upward by [_bulletSpeed] px
  final double _bulletSpeed = 10.0;

  List<IBullet> get bullets => _bullets;
  final List<IBullet> _bullets = [];

  //todo: try without CancelableOperation
  CancelableOperation? _cancelableOperation;
  Timer? _timer;

  //bullet movement  controller
  Timer? _timerBulletMovement;

  PlayerInfoNotifier({
    required this.ref,
  });

  /// update player vertical position
  void updateTopPosition(double dY) {
    player.position.dY = dY;
    notifyListeners();
  }

  ///update player horizontal position
  void updateLeftPosition(double dX) {
    player.position.dX = dX;
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

  void _addBullet() {
    _bullets.add(
      PlayerShipBullet(
        position: Vector2.fromValue(player.position)
          ..dX = player.position.dX +
              player.size.width / 2 - //fire from top center
              PlayerShipBullet.bulletWidth / 2, // position on middle
      ),
    );
    notifyListeners();
  }

  ///*  player bullets will move up(-Y) on Every Frame(lie, on [bulletMovementRate])
  /// removed removeable objects end of the timer loop.
  /// ----
  /// * remove enemy on bullet collision, removeable object on removeable list
  /// * destroy EnemyShip and player bullet on collision
  /// * increase score while bullet hit enemyShip
  /// * add blust while destroying ship
  void _bulletsMovement() {
    //* variables to hold and perform operation all at once
    // remove theses from player `_bullets`
    List<IBullet> removeableBullets = [];

    // call enemyProvider and remove theses ship
    List<IShip> removeableShip = [];

    // include theses on blustProvider
    List<Vector2> addableBlustPos = [];

    // this timer is active on playing mode
    if (_timerBulletMovement != null && _timerBulletMovement!.isActive) return;
    _timerBulletMovement = Timer.periodic(
      bulletMovementRate,
      (timer) {
        if (_bullets.isEmpty) return;

        final enemyNotifier = ref.read(enemyProvider);

        for (final b in _bullets) {
          b.position.dY -= _bulletSpeed;
          // remove bullet while it is beyond screen:at Top
          if (b.position.dY < 0) removeableBullets.add(b);

          for (final enemyShip in enemyNotifier.enemies) {
            // checking if ship within bullet  position
            if (collisionChecker(a: enemyShip, b: b)) {
              removeableShip.add(enemyShip);
              removeableBullets.add(b);
              addableBlustPos.add(enemyShip.position);
              scoreManager = EnemyShipDestroyScore(playerScore: scoreManager);
            }
          }
        }
        // removed removeable object
        _bullets.removeAll(removeableBullets);
        enemyNotifier.removeEnemies(ships: removeableShip);
        enemyNotifier.addBlusts(addableBlustPos);
        addableBlustPos.clear();
        removeableBullets.clear();
        removeableShip.clear();
        notifyListeners();
      },
    );
  }

  //*---------------------------*
  //*  Score Health Management  *
  //*---------------------------*
  /// increment score of player by destroying enemies

  /// decrease player health
  void updateHeathStatus(Type type) {
    if (type == DamageOnEB) {
      player.health = DamageOnEB(iShipHealth: player.health);
    }
    if (type == DamageOnShipCollision) {
      player.health = DamageOnShipCollision(iShipHealth: player.health);
    }
    if (type == GeneralHealingBox) {
      player.health = GeneralHealingBox(iShipHealth: player.health);
    }
    //todo: GameOver while 0 score
    notifyListeners();
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*
  /// stop player, bullet,generator
  pauseMode() {
    _timerBulletMovement?.cancel();
  }

  /// start player bullets movement
  payingMode() {
    _bulletsMovement();

    // debugPrint("playerProvider: PlayingMode");
    // debugPrint("BulletMovement Timer ${_timerBulletMovement == null}");
  }
}
