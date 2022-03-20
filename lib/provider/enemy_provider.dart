import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../model/model.dart';
import '../screens/on_play/utils/utils.dart';
import '../extensions/extensions.dart';
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
  Size screenSize = GObjectSize.instatnce.screen;

  EnemyChangeNotifier(this.ref) {
    // _enemyMovement();
  }

  final List<IBullet> _bullets = [];

  /// enemy ship bullets
  List<IBullet> get bullets => _bullets;

  final List<IShip> _enemies = [];
  List<IShip> get enemies => _enemies;

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
    //todo: create handler
    _timerEnemyGeneration = Timer.periodic(enemyGenerateDuration, (t) {
      _enemies.addAll(
        List.generate(
          _generateNxEmeny,
          (index) => EnemyShip(
            position: _enemyInitPosition(),
          ),
        ),
      );
      notifyListeners();
    });
  }

  ///generate random position for enemy
  Vector2 _enemyInitPosition() {
    // to avoid boundary confliction
    final randX = _random.nextDouble() * screenSize.width;
    final dx = randX - 40 < 0
        ? randX + 40
        : randX + 40 > screenSize.width
            ? randX - 40
            : randX;
    //todo: random dY for multi-generation
    return Vector2(dX: dx, dY: 0);
  }

  /// move downward and destroy while it is downSide:enemyShip
  ///* check playerShip colision with enemyShip
  /// > * remove enemyShip,
  /// > * decrease playerShip health
  void _enemyMovement() {
    List<IShip> removeableShip = [];
    List<Vector2> addableBulst = [];

    _timerEnemyMovement = Timer.periodic(enemyMovementRate, (timer) {
      if (_enemies.isEmpty) return;

      final playerNotifier = ref.read(playerInfoProvider);
      final player = playerNotifier.player;

      for (final enemy in _enemies) {
        enemy.position.dY += enemyMovementPY;

        if (enemy.position.dY > screenSize.height) {
          removeableShip.add(enemy);
          continue;
        }

        /// check playerShip colision with enemyShip
        /// remove enemyShip, decrease playerShip health
        if (collisionChecker(a: enemy, b: player)) {
          removeableShip.add(enemy);
          playerNotifier.updateHeathStatus(DamageOnShipCollision);
          addableBulst.add(enemy.position.value);
        }
      }
      // debugPrint("total enemyShip: ${_enemies.length}");

      // update objects
      if (removeableShip.isNotEmpty) {
        _enemies.removeAll(removeableShip);
        removeableShip.clear();
      }
      if (addableBulst.isNotEmpty) {
        addBlusts(addableBulst);
        addableBulst.clear();
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

      for (IShip ship in _enemies) {
        //todo: check if is needed temp
        //not all enemy will fire
        if (_random.nextBool()) {
          _bullets.add(
            EnemyShipBullet(
              color: ship.color,
              position: ship.position.value
                ..dX = ship.position.dX +
                    ship.size.width / 2 -
                    GObjectSize.instatnce.enemyBullet.width /
                        2, //precise position
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
        b.position.dY += bulletMoventPY;

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
    required List<IShip> ships,
  }) {
    _enemies.removeAll(ships);
    notifyListeners();
  }

  void removeBullets({
    required List<IBullet> bullets,
  }) {
    _bullets.removeAll(bullets);
    notifyListeners();
  }

  ///* track the ship destroy position and show [MagicBall.singleBlust()]
  /// need to shrink the size, max blust can be `_maxBlustNumber:10`
  /// blust effect cant be controlled/pasue by GameManager
  final List<Vector2> _shipsBlustLocation = [];

  /// ships positions on (player bullet) destroy, used to show blust
  List<Vector2> get shipsBlustLocation => _shipsBlustLocation;

  /// number of blust can shown on ui, used to reduce the object
  final int _maxBlustNumber = 10;

  //todo: add setter

  /// * add blustPosition from outSide
  /// add [Vector2] to show blust , used this method on [_enemyShipCollision]
  /// method for future purpose:audio
  void addBlusts(List<Vector2> v2) {
    _shipsBlustLocation.insertAll(0, v2);

    /// reduce size while list becomes `_maxBlustNumber`
    if (_shipsBlustLocation.length > _maxBlustNumber) {
      _shipsBlustLocation.removeRange(
        _maxBlustNumber ~/ 2,
        _shipsBlustLocation.length,
      );
    }

    // debugPrint("blust Number ${_shipsBlustLocation.length}");
    notifyListeners();
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
