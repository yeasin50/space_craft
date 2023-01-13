import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector2/vector2.dart';

import '../../../core/constants/constants.dart';
import '../../../core/entities/entities.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/providers/object_scalar.dart';
import '../../../core/utils/utils.dart';
import '../../setting/providers/providers.dart';
import '../models/models.dart';
import '../on_play.dart';
import 'provider.dart';

final enemyProvider = ChangeNotifierProvider<EnemyChangeNotifier>(
  (ref) {
    return EnemyChangeNotifier(ref);
  },
);

//todo: test with single refresh method: [notifier]
class EnemyChangeNotifier extends ChangeNotifier with GameState, OnObstacleHit {
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

  /// move enemy down by  `bulletMomentPY` px
  double bulletMomentPY = 10.0;

  final Duration _bulletMovementRate = const Duration(milliseconds: 70);

  ///Enemy GeneratePer [enemyGenerateDuration]
  final int _generateNxEnemy = 2;

  ///start Enemy creator,
  void _generateEnemies() {
    _timerEnemyGeneration = Timer.periodic(enemyGenerateDuration, (t) {
      _enemies.addAll(
        List.generate(_generateNxEnemy, (index) {
          return EnemyShip(
            position: _enemyInitPosition(index: index),
          );
        }),
      );
      notifyListeners();
    });
  }

  ///generate random position for enemy
  Vector2 _enemyInitPosition({int index = 0}) {
    // return randomEnemyInitPosition();
    return enemyInitPositionByTricker(
        (_timerEnemyGeneration?.tick ?? 0) + index);
  }

  /// move downward and destroy while it is downSide:enemyShip
  ///* check playerShip collision with enemyShip
  /// > * remove enemyShip,
  /// > * decrease playerShip health
  void _enemyMovement() {
    _timerEnemyMovement = Timer.periodic(enemyMovementRate, (timer) {
      List<EnemyShip> removableShip = [];

      if (_enemies.isEmpty) return;

      final playerNotifier = ref.read(playerInfoProvider);
      final player = playerNotifier.player;

      /// check if enemy is OK
      for (final enemy in _enemies.toList()) {
        if (!isWorkable(enemy)) continue;

        enemy.position.update(dY: enemy.position.dY + enemyMovementPY);

        if (enemy.position.dY > screenSize.height) {
          removableShip.add(enemy);
          continue;
        }

        /// check playerShip collision with enemyShip
        /// remove enemyShip, decrease playerShip health
        ///* improving enemy collision by dividing ship into two parts,  instead of directly using player size, we will use `GObjectSize.playerShipTopPart` and `GObjectSize.playerShipBottomPart`
        if (collisionChecker(a: enemy, b: player.bottomPart) ||
            collisionChecker(a: enemy, b: player.topPart)) {
          removableShip.add(enemy);
          playerNotifier.onShipHit();
          onShipHit(gameObject: enemy);
        }
      }
      // debugPrint("total enemyShip: ${_enemies.length}");

      // update objects
      if (removableShip.isNotEmpty) {
        _enemies.removeAll(removableShip);
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
        if (!isWorkable(ship)) continue;
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
      List<IBullet> removableBullets = [];

      for (final b in _bullets) {
        b.position.update(dY: b.position.dY + bulletMomentPY);

        //check bullet collision with player collision or beyond screen
        final bool isCollided =
            collisionChecker(b: b, a: playerNotifier.player);
        if (isCollided || b.position.dY > screenSize.height) {
          removableBullets.add(b);
          if (isCollided) {
            playerNotifier.onBulletHit();
          }
        }
      }
      _bullets.removeAll(removableBullets);
      notifyListeners();
    });
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

  ///* track the ship destroy position and show [MagicBall.singleBlast()]
  /// need to shrink the size, max blast can be `_maxBlastNumber:10`
  /// blast effect cant be controlled/pause by GameManager
  /// todo: blast will be replaced by rive effect
  final List<Vector2> _shipsBlastLocation = [];

  /// ships positions on (player bullet) destroy, used to show blast
  ///
  /// [SpaceInvaderSettingProvider.instance.effect] must be true to show blast effect
  // we can also bypass adding blast
  List<Vector2> get shipsBlastLocation =>
      SpaceInvaderSettingProvider.instance.effect ? _shipsBlastLocation : [];

  /// number of blast can shown on ui, used to reduce the object
  final int _maxBlastNumber = 10;

  //todo: add setter, make singular

  /// * add blastPosition from outSide
  /// add [Vector2] to show blast , used this method on [_enemyShipCollision]
  /// method for future purpose:audio;
  void _addBlasts(List<Vector2> v2) {
    if (v2.isEmpty) return;
    // debugPrint("add blast");
    _shipsBlastLocation.insertAll(0, v2);

    /// reduce size while list becomes `_maxBlastNumber`
    if (_shipsBlastLocation.length > _maxBlastNumber) {
      _shipsBlastLocation.removeRange(
        _maxBlastNumber ~/ 2,
        _shipsBlastLocation.length,
      );
    }
    notifyListeners();
    // debugPrint("blast Number ${_shipsBlastLocation.length}");
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*

  void _startTimers() {
    _generateEnemies();
    _enemyMovement();
    _generateBullet();
    _bulletMovement();
  }

  /// Cancel all activity
  void _cancelTimers() {
    _timerEnemyGeneration?.cancel();
    _timerEnemyMovement?.cancel();
    _timerBulletGenerator?.cancel();
    _timerBulletMovement?.cancel();
  }

  @override
  void onPause() {
    _cancelTimers();
  }

  @override
  void onPlay() {
    _startTimers();
  }

  @override
  void onReset() {
    // TODO: implement onReset
  }

  @override
  void onResume() {
    _startTimers();
  }

  @override
  void idle() {
    // TODO: implement onStart
  }

  @override
  void onBorderHit({GameObject? gameObject}) {
    // TODO: implement onBorderHit
  }

  @override
  void onBulletHit({GameObject? gameObject}) async {
    if (gameObject is EnemyShip) {
      gameObject.state = ShipState.glitch;
      notifyListeners();
      Future.delayed(gameObject.state.duration).then((_) {
        gameObject.state = ShipState.dead;
        _enemies.remove(gameObject);
        notifyListeners();
      });
    }
  }

  @override
  void onEnergyHit({GameObject? gameObject}) {
    // TODO: implement onEnergyHit
  }

  @override
  void onShipHit({GameObject? gameObject}) {
    if (gameObject is EnemyShip) {
      // add blast effect and remove
      _addBlasts([gameObject.position]);
      _enemies.remove(gameObject);
      notifyListeners();
    }
  }
}
