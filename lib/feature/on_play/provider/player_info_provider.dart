import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_craft/feature/setting/providers/providers.dart';

import '../../../core/entities/entities.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/providers/object_scalar.dart' as game_object;
import '../../../core/utils/utils.dart';
import '../models/models.dart';
import 'provider.dart';

final playerInfoProvider = ChangeNotifierProvider<PlayerInfoNotifier>(
  (ref) {
    return PlayerInfoNotifier(ref: ref);
  },
);

///this provide Player UI update info
class PlayerInfoNotifier extends ChangeNotifier
    with GameState, PlayerAction, OnObstacleHit {
  final ChangeNotifierProviderRef ref;

  IPlayerScore scoreManager = PlayerScoreManager();
  IShipHealth shipHealthManager = PlayerHealthManager();

  final Player _initPlayer = Player(
    position: Vector2(
      dX: game_object.GObjectSize.instance.screen.width / 2,
      dY: game_object.GObjectSize.instance.screen.height * .75,
    ),
  );

  /// create player instance
  late Player player = _initPlayer;

  final Duration bulletGenerateRate = const Duration(milliseconds: 400);
  final Duration bulletMovementRate = const Duration(milliseconds: 50);

  // bullet will move upward by [_bulletSpeed] px
  final double _bulletSpeed = 10.0;

  List<IBullet> get bullets => _bullets;
  final List<IBullet> _bullets = [];

  Timer? _timer;

  //bullet movement  controller
  Timer? _timerBulletMovement;

  PlayerInfoNotifier({
    required this.ref,
  });

  /// Update player position
  void updatePosition({double? dX, double? dY}) {
    // debugPrint(player.position.toString());
    player.position.update(dX: dX, dY: dY);

    //todo: create setting for theses
    _enemyCollisionChecker();
    _healthBoxCollision();
    _enemyBulletCollision();

    notifyListeners();
  }

  ///start player bullet generation and movement
  @override
  void startShooting() {
    //can include a bullet just on tap,
    player.shoot = true;

    _timer?.cancel();
    _timer = Timer.periodic(bulletGenerateRate, (timer) {
      _addBullet();
    });
    _bulletsMovement();
    notifyListeners();
  }

  @override
  void stopShooting() {
    player.shoot = false;
    _timer?.cancel();
    notifyListeners();
  }

  void _addBullet() {
    _bullets.add(
      PlayerShipBullet(
        position: player.position.copyWith(
          dX: player.position.dX +
              player.size.width / 2 - //fire from top center
              game_object.GObjectSize.instance.playerBullet.width /
                  2, // position on middle
        ),
      ),
    );
    notifyListeners();
  }

  ///*  player bullets will move up(-Y) on Every Frame(lie, on [bulletMovementRate])
  /// removed removable objects end of the timer loop.
  /// ----
  /// * remove enemy on bullet collision, removable object on removable list
  /// * destroy EnemyShip and player bullet on collision
  /// * increase score while bullet hit enemyShip
  /// * add blast while destroying ship
  void _bulletsMovement() {
    // this timer is active on playing mode
    if (_timerBulletMovement != null && _timerBulletMovement!.isActive) return;
    _timerBulletMovement = Timer.periodic(
      bulletMovementRate,
      (timer) {
        //* variables to hold and perform operation all at once
        // remove theses from player `_bullets`
        List<IBullet> removableBullets = [];

        // call enemyProvider and remove theses ship
        List<EnemyShip> removableShip = [];

        // include theses on blastProvider
        List<Vector2> addableBlastPos = [];

        if (_bullets.isEmpty) return;

        final enemyNotifier = ref.read(enemyProvider);

        for (final b in _bullets) {
          b.position.update(dY: b.position.dY - _bulletSpeed);
          // remove bullet while it is beyond screen:at Top
          if (b.position.dY < 0) removableBullets.add(b);

          for (final enemyShip in enemyNotifier.enemies) {
            // checking if ship within bullet  position
            if (collisionChecker(a: enemyShip, b: b)) {
              removableShip.add(enemyShip);
              removableBullets.add(b);
              addableBlastPos.add(enemyShip.position);
              scoreManager = EnemyShipDestroyScore(playerScore: scoreManager);
            }
          }
        }
        // removed removable object
        _bullets.removeAll(removableBullets);
        enemyNotifier.removeEnemies(ships: removableShip);
        enemyNotifier.addBlasts(addableBlastPos);
        notifyListeners();
      },
    );
  }

  /// realTime Collision between EnemyShip on PlayerShip movement.
  /// while it get touch with playerShip
  /// used on playerShip movement [updatePosition]
  /// * this method doesn't notify the update
  void _enemyCollisionChecker() {
    final enemyNotifier = ref.read(enemyProvider);
    List<EnemyShip> removableEnemy = [];
    for (final enemy in enemyNotifier.enemies) {
      ///todo: we can also use
      /// collisionChecker(a: enemy, b: player.bottomPart) || collisionChecker(a: enemy, b: player.topPart))
      if (collisionChecker(a: enemy, b: player)) {
        removableEnemy.add(enemy);
        onShipHit();
      }
    }

    enemyNotifier.removeEnemies(ships: removableEnemy);

    // no need to notify, `removeEnemies` handle this;
  }

  /// realTime Collision between HealthBox and Player movement
  /// value will be notify by inner or outline the method
  /// * this method doesn't notify the update
  void _healthBoxCollision() {
    final healthBoxNotifier = ref.read(healingObjectProvider);

    List<GeneralHealingBox> removableBox = [];

    for (final hb in healthBoxNotifier.healingBoxes) {
      if (collisionChecker(a: hb, b: player)) {
        onEnergyHit();
        removableBox.add(hb);
      }
    }
    healthBoxNotifier.removeBox(healingBox: removableBox);
  }

  /// realTime Collision between Enemy's bullets and Player movement
  /// * this method doesn't notify the update
  void _enemyBulletCollision() {
    final enemyNotifier = ref.read(enemyProvider);

    final List<IBullet> removableBullet = [];

    for (final bullet in enemyNotifier.bullets) {
      if (collisionChecker(a: bullet, b: player)) {
        removableBullet.add(bullet);
      }
    }
    enemyNotifier.removeBullets(bullets: removableBullet);
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*

  @override
  void onPause() {
    _timerBulletMovement?.cancel();
    stopShooting();
  }

  @override
  void onPlay() {
    // `_player` notified by next methods
    // player = _initPlayer;

    // todo: set controller for touch and keyboard mode; disable on touch mode
    if (SpaceInvaderSettingProvider.instance.freeFire) startShooting();
  }

  @override
  void onReset() {
    // TODO: implement onReset
  }

  @override
  void onResume() {
    debugPrint(" playerInfoProvider: resumed");
    _bulletsMovement();
    if (SpaceInvaderSettingProvider.instance.freeFire) startShooting();
  }

  @override
  void idle() {}

  //*---------------------------*
  //*  Score Health Management  *
  //*---------------------------*
  /// increment score of player by destroying enemies

  @override
  void onBorderHit({GameObject? gameObject}) {
    // TODO: implement onBorderHit
  }

  @override
  void onBulletHit({GameObject? gameObject}) {
    player.health = DamageOnEB(iShipHealth: player.health);
    notifyListeners();
  }

  @override
  void onEnergyHit({GameObject? gameObject}) {
    player.health = GeneralHealingBox(iShipHealth: player.health);
    notifyListeners();
  }

  @override
  void onShipHit({GameObject? gameObject}) {
    player.health = DamageOnShipCollision(iShipHealth: player.health);
    notifyListeners();
  }
}
