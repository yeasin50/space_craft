import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../model/model.dart';
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
  Size? _screenSize;

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
    _enemyMovement();
    generateBullet();
  }

  // create enemyShip on (,0) possition
  _addEnemy() {
    assert(
      (_screenSize != null),
      '''got null on _screenSize use [initScreen] to set _screenSize.[enemy_provider.dart 38:44]''',
    );

    // to avoid boundary confliction
    final randX = _random.nextDouble() * _screenSize!.width;
    final dx = randX - 40 < 0
        ? randX + 40
        : randX + 40 > _screenSize!.width
            ? randX - 40
            : randX;
    //todo: random dY for multi-generation
    _enemies.add(
      EnemyShip(
        position2d: Vector2(
          dX: dx,
          dY: 0.0,
        ),
      ),
    );
    notifyListeners();
  }

  /// move downward and destroy while it is downSide:enemyShip
  _enemyMovement() {
    _timerEnemyMovement = Timer.periodic(enemyMovementRate, (timer) {
      if (_enemies.isEmpty) return;

      for (final e in _enemies) {
        e.position2d.dY += enemyMovementPY;

        _checkPlayerShipCollision();

        if (e.position2d.dY > _screenSize!.height) {
          removeEnemy(e);
        }
      }

      // debugPrint("total enemyShip: ${_enemies.length}");
      notifyListeners();
    });

    notifyListeners();
  }

  /// remove enemy from
  removeEnemy(EnemyShip e) {
    _enemies.remove(e);
    notifyListeners();
  }

  /// Enemy Bullets
  generateBullet() {
    _timerBulletGenerator = Timer.periodic(_bulletGeneratorDelay, (timer) {
      _addBullet();
    });
    _bulletMovement();
  }

  /// adding bullets based on enemy position
  _addBullet() {
    if (_enemies.isEmpty) return;

    for (var e in _enemies) {
      //todo: min the bullet width and should i add bullet property on [EnemyShip] level, or create random timer
      if (_random.nextBool()) {
        _bullets.add(
          EnemyShipBullet(
            position: e.position2d.value
              ..dX = e.position2d.dX +
                  e.size.width / 2 -
                  EnemyShipBullet.bulletWidth / 2, //precise position
          ),
        );
      }
    }
    // debugPrint("total _bullet: ${_bullets.length}");
    //todo: check if notifier is needed to make it smooth
  }

  /// bullet movement on separate method: movement needed to be smooth while controlling the enemy generation
  _bulletMovement() {
    _timerBulletMovement = Timer.periodic(_bulletMovementRate, (timer) {
      if (_bullets.isEmpty) return;

      for (final b in _bullets) {
        b.position.dY += bulletMoventPY;

        if (b.position.dY > _screenSize!.height) {
          _bullets.remove(b);
        }
      }
      notifyListeners();
    });
  }

  /// playerShip colision with enemyShip
  /// remove enemyShip, decrease playerShip health
  void _checkPlayerShipCollision() {
    // what if I use `_removeEnemyOnBulletCollision()`

    final player = ref.read(playerInfoProvider).player;

    for (final enemyShip in _enemies) {
      // checking if ship within bullet  position
      if (enemyShip.position2d.dX <= player.position2d.dX + player.size.width &&
          enemyShip.position2d.dX >=
              player.position2d.dX - player.size.width / 2 &&
          enemyShip.position2d.dY >=
              player.position2d.dY - player.size.height / 2 &&
          enemyShip.position2d.dY <=
              player.position2d.dY + player.size.height / 2) {
        removeEnemy(enemyShip);
        //todo: damage playerShip
        debugPrint("rm Enemy");
      }
    }
  }

  //** Controllers */

  /// if true, stop enemymovement+ geration..+bullets
  pauseMode({
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
