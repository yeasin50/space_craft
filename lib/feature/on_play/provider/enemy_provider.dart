import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import 'provider.dart';

final enemyProvider = ChangeNotifierProvider<EnemyChangeNotifier>(
  (ref) {
    return EnemyChangeNotifier(ref);
  },
);

//todo: test with single refresh method: [notifier]
class EnemyChangeNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;
  // screen size to control enemy movement
  Size screenSize = GObjectSize.instance.screen;

  EnemyChangeNotifier(this.ref) {
    // _enemyMovement();
  }

  final List<IBullet> _bullets = [];

  /// enemy ship bullets
  List<IBullet> get bullets => _bullets;

  final List<EnemyShip> _enemies = [];
  List<EnemyShip> get enemies => _enemies;

  //enemy generation on different x position
  final math.Random _random = math.Random();

  //todo: create cancelable if needed later
  Timer? _timerEnemyGeneration;
  Timer? _timerEnemyMovement;
  Timer? _timerBulletGenerator;
  Timer? _timerBulletMovement;

  /// move enemy down by  `enemyMovementPY` px
  double enemyMovementPY = 4.0;

  /// move enemy down on every `enemyMovementRate` [Duration]
  final Duration enemyMovementRate = const Duration(milliseconds: 200);

  /// Generate single enemy on every  `enemyGenerateDuration` [Duration]
  final Duration enemyGenerateDuration = const Duration(seconds: 2);

  final Duration _bulletGeneratorDelay = const Duration(seconds: 1);

  /// move enemy down by  `bulletMoventPY` px
  double bulletMoventPY = 10.0;

  final Duration _bulletMovementRate = const Duration(milliseconds: 70);

  ///Enemy GeneratePer [enemyGenerateDuration]
  final int _generateNxEmeny = 2;

  ///start Enemy creator,
  void _generateEnemies() {
    _timerEnemyGeneration = Timer.periodic(enemyGenerateDuration, (t) {
      _enemies.addAll(
        List.generate(_generateNxEmeny, (index) {
          return EnemyShip(
            position: _enemyInitPosition(),
          );
        }),
      );
      notifyListeners();
    });
  }

  ///generate random position for enemy
  Vector2 _enemyInitPosition() {
    // if (enemies.isNotEmpty) {
    //spacing between last generated ship
    //FIXME:  handle enemy generator spacing
    //   do {
    //     randX = _random.nextDouble() * screenSize.width;
    //     debugPrint("inner $randX");
    //   } while (
    //       (randX - _enemies.last.position.dX).abs() < screenSize.width * .15);
    // } else {
    double randX = _random.nextDouble() * screenSize.width;
    // }

    // to avoid boundary confliction
    final dx = randX - 40 < 0
        ? randX + 40
        : randX + 40 > screenSize.width
            ? randX - 40
            : randX;

    final dy = -_random.nextDouble() * (screenSize.height * .15);
    return Vector2(dX: dx, dY: dy);
  }

  /// move downward and destroy while it is downSide:enemyShip
  ///* check playerShip collision with enemyShip
  /// > * remove enemyShip,
  /// > * decrease playerShip health
  void _enemyMovement() {
    List<EnemyShip> removeableShip = [];
    List<Vector2> addableBlast = [];

    _timerEnemyMovement = Timer.periodic(enemyMovementRate, (timer) {
      if (_enemies.isEmpty) return;

      final playerNotifier = ref.read(playerInfoProvider);
      final player = playerNotifier.player;

      for (final enemy in _enemies) {
        enemy.position.update(dY: enemy.position.dY + enemyMovementPY);

        if (enemy.position.dY > screenSize.height) {
          removeableShip.add(enemy);
          continue;
        }

        /// check playerShip colision with enemyShip
        /// remove enemyShip, decrease playerShip health
        ///* improving enemy colission by dividing ship into two parts,  instead of directly using player size, we will use `GObjectSize.playerShipTopPart` and `GObjectSize.playerShipBottomPart`
        if (collisionChecker(a: enemy, b: player.bottomPart) ||
            collisionChecker(a: enemy, b: player.topPart)) {
          removeableShip.add(enemy);
          playerNotifier.updateHeathStatus(DamageOnShipCollision);
          addableBlast.add(enemy.position.value);
        }
      }
      // debugPrint("total enemyShip: ${_enemies.length}");

      // update objects
      if (removeableShip.isNotEmpty) {
        _enemies.removeAll(removeableShip);
        removeableShip.clear();
      }
      if (addableBlast.isNotEmpty) {
        addblasts(addableBlast);
        addableBlast.clear();
      }

      notifyListeners();
    });

    notifyListeners();
  }

  /// Enemy Bullets generation based on [_bulletGeneratorDelay].
  /// Add bullet based on enemy position
  void _generateBullet() {
    _timerBulletGenerator = Timer.periodic(_bulletGeneratorDelay, (timer) {
      if (_enemies.isEmpty) return;

      for (EnemyShip ship in _enemies) {
        //fire only when ship is visible on ui
        if (ship.position.dY < ship.size.height) continue;

        if (_random.nextBool()) {
          _switchEnemyShipState(ship);
          _bullets.add(
            EnemyShipBullet(
              color: ship.color,
              position: ship.position.copyWith(
                dX: ship.position.dX +
                    ship.size.width / 2 -
                    GObjectSize.instance.enemyBullet.width /
                        2, //precise position
              ),
            ),
          );
        }
      }
      notifyListeners();
    });
  }

  /// bullet movement on separate method: movement needed to be smooth while controlling the enemy generation
  void _bulletMovement() {
    _timerBulletMovement = Timer.periodic(_bulletMovementRate, (timer) {
      if (_bullets.isEmpty) return;

      final playerNotifier = ref.read(playerInfoProvider);

      /// clear all bullet on Timer
      List<IBullet> removeableBullets = [];

      for (final b in _bullets) {
        b.position.update(dY: b.position.dY + bulletMoventPY);

        //check bullet collision with player collision or beyond screen
        final bool _c = collisionChecker(b: b, a: playerNotifier.player);
        if (_c || b.position.dY > screenSize.height) {
          removeableBullets.add(b);
          if (_c) {
            playerNotifier.updateHeathStatus(DamageOnEB);
          }
        }
      }
      _bullets.removeAll(removeableBullets);
      //todo: how can i dispose list to free memory
      removeableBullets.clear(); //? not needed
      notifyListeners();
    });
  }

  ///* remove enemy-ships from current: OutSider
  void removeEnemies({
    required List<EnemyShip> ships,
  }) {
    if (ships.isEmpty) return;
    _enemies.removeAll(ships);
    notifyListeners();
  }

  void removeBullets({
    required List<IBullet> bullets,
  }) {
    if (bullets.isEmpty) return;
    _bullets.removeAll(bullets);
    notifyListeners();
  }

  /// Ship Movement Effect on fire
  /// change image state to show a little animation,
  /// todo: check if we want separate movement controller::timer,
  void _switchEnemyShipState(EnemyShip enemy) {
    // enemy.switchImageState();
    enemy.switchImageState();

    // debugPrint(" ${enemy.imageState}");
  }

  ///* track the ship destroy position and show [MagicBall.singleblast()]
  /// need to shrink the size, max blast can be `_maxblastNumber:10`
  /// blast effect cant be controlled/pasue by GameManager
  /// todo: blast will be replaced by rive effect
  final List<Vector2> _shipsBlastLocation = [];

  /// ships positions on (player bullet) destroy, used to show blast
  ///
  /// [UserSetting.instance.effect] must be true to show blast effet
  // we can also bypass adding blast
  List<Vector2> get shipsblastLocation =>
      UserSetting.instance.effect ? _shipsBlastLocation : [];

  /// number of blast can shown on ui, used to reduce the object
  final int _maxblastNumber = 10;

  //todo: add setter

  /// * add blastPosition from outSide
  /// add [Vector2] to show blast , used this method on [_enemyShipCollision]
  /// method for future purpose:audio;
  void addblasts(List<Vector2> v2) {
    if (v2.isEmpty) return;
    // debugPrint("add blast");
    _shipsBlastLocation.insertAll(0, v2);

    /// reduce size while list becomes `_maxblastNumber`
    if (_shipsBlastLocation.length > _maxblastNumber) {
      _shipsBlastLocation.removeRange(
        _maxblastNumber ~/ 2,
        _shipsBlastLocation.length,
      );
    }
    notifyListeners();
    // debugPrint("blast Number ${_shipsblastLocation.length}");
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*

  /// call while game is running and needed to genrate enemy
  ///* preodicly enemy creation
  ///* start EnemyMovemnt
  ///* generate Enemies bullet and movement
  void playMode() {
    _generateEnemies();
    _enemyMovement();
    _generateBullet();
    _bulletMovement();
  }

  /// if true, stop enemymovement+ geration..+bullets
  void pauseMode({
    bool movement = true,
    bool generator = true,
    bool bulletMovement = true,
    bool bulletGenerator = true,
  }) {
    if (generator && _timerEnemyGeneration != null) {
      _timerEnemyGeneration!.cancel();
    }
    if (movement && _timerEnemyMovement != null) {
      _timerEnemyMovement!.cancel();
    }

    if (bulletGenerator && _timerBulletGenerator != null) {
      _timerBulletGenerator!.cancel();
    }
    if (bulletMovement && _timerBulletMovement != null) {
      _timerBulletMovement!.cancel();
    }
  }
}
