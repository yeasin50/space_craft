import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../constants/constants.dart';
import '../model/model.dart';
import '../screens/on_play/utils/utils.dart';
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

  ///get screen Size ://todo: move to GameManager
  Size get screenSize => _screenSize ?? Size.zero;

  void initScreen({required Size screenSize}) {
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
        position: Vector2(
          dX: dx,
          dY: 0.0,
        ),
        color: getRandomColor,
      ),
    );
    notifyListeners();
  }

  /// move downward and destroy while it is downSide:enemyShip
  _enemyMovement() {
    _timerEnemyMovement = Timer.periodic(enemyMovementRate, (timer) {
      if (_enemies.isEmpty) return;

      for (final e in _enemies) {
        e.position.dY += enemyMovementPY;

        _enemyShipCollision();

        if (e.position.dY > _screenSize!.height) {
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
            color: e.color,
            position: e.position.value
              ..dX = e.position.dX +
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

      final playerNotifier = ref.read(playerInfoProvider);

      for (final b in _bullets) {
        b.position.dY += bulletMoventPY;

        //check bullet collision with player collision or beyond screen
        final bool _c = collisionChecker(b: b, a: playerNotifier.player);
        if (_c || b.position.dY > _screenSize!.height) {
          _bullets.remove(b);
          if (_c) {
            playerNotifier.updateHeathStatus(DamageOnEB);
          }
        }
      }
      notifyListeners();
    });
  }

  /// check playerShip colision with enemyShip
  /// remove enemyShip, decrease playerShip health
  void _enemyShipCollision() {
    // what if I use `_removeEnemyOnBulletCollision()`

    final playerNotifier = ref.read(playerInfoProvider);
    final player = playerNotifier.player;

    for (final enemyShip in _enemies) {
      // checking if ship within bullet  position
      if (enemyShip.position.dX <= player.position.dX + player.size.width &&
          enemyShip.position.dX >= player.position.dX - player.size.width / 2 &&
          enemyShip.position.dY >=
              player.position.dY - player.size.height / 2 &&
          enemyShip.position.dY <=
              player.position.dY + player.size.height / 2) {
        removeEnemy(enemyShip);
        playerNotifier.updateHeathStatus(DamageOnShipCollision);
        debugPrint("rm Enemy");
      }
    }
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*
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
