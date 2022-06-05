import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_craft/feature/setting/models/models.dart';
import 'package:space_craft/feature/sound/sound_manager.dart';

import '../../../core/entities/entities.dart';
import '../../../core/extensions/extensions.dart';
import '../../setting/models/object_scalar.dart';
import '../models/models.dart';
import '../utils/utils.dart';
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

  Timer? _timer;

  //bullet movement  controller
  Timer? _timerBulletMovement;

  PlayerInfoNotifier({
    required this.ref,
  });

  /// Update player position
  void updatePosition({double? dX, double? dY}) {
    player.position.update(dX: dX, dY: dY);

    //todo: create setting for theses
    _enemyCollisionChecker();
    _healthBoxCollision();
    _enemyBulletCollision();

    notifyListeners();
  }

  ///start player bullet generation and movement
  void startShooting() {
    //can include a bullet just on tap,
    player.shoot = true;

    _timer?.cancel();
    _timer = Timer.periodic(bulletGenerateRate, (timer) {
      _addBullet();
    });
    _bulletsMovement();
  }

  void stopShooting() {
    player.shoot = false;
    _timer?.cancel();
    notifyListeners();
  }

  void _addBullet() {
    ///TODO: bullet sound
    if (UserSetting.instance.sound) {
      SoundManager.playSilencer();
    }
    _bullets.add(
      PlayerShipBullet(
        position: player.position.copyWith(
          dX: player.position.dX +
              player.size.width / 2 - //fire from top center
              GObjectSize.instance.playerBullet.width / 2, // position on middle
        ),
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
  /// * add blast while destroying ship
  void _bulletsMovement() {
    //* variables to hold and perform operation all at once
    // remove theses from player `_bullets`
    List<IBullet> removeableBullets = [];

    // call enemyProvider and remove theses ship
    List<EnemyShip> removeableShip = [];

    // include theses on blastProvider
    List<Vector2> addableblastPos = [];

    // this timer is active on playing mode
    if (_timerBulletMovement != null && _timerBulletMovement!.isActive) return;
    _timerBulletMovement = Timer.periodic(
      bulletMovementRate,
      (timer) {
        if (_bullets.isEmpty) return;

        final enemyNotifier = ref.read(enemyProvider);

        for (final b in _bullets) {
          b.position.update(dY: b.position.dY - _bulletSpeed);
          // remove bullet while it is beyond screen:at Top
          if (b.position.dY < 0) removeableBullets.add(b);

          for (final enemyShip in enemyNotifier.enemies) {
            // checking if ship within bullet  position
            if (collisionChecker(a: enemyShip, b: b)) {
              removeableShip.add(enemyShip);
              removeableBullets.add(b);
              addableblastPos.add(enemyShip.position);
              scoreManager = EnemyShipDestroyScore(playerScore: scoreManager);
            }
          }
        }
        // removed removeable object
        _bullets.removeAll(removeableBullets);
        enemyNotifier.removeEnemies(ships: removeableShip);
        enemyNotifier.addblasts(addableblastPos);
        addableblastPos.clear();
        removeableBullets.clear();
        removeableShip.clear();
        notifyListeners();
      },
    );
  }

  /// realTime Collision between EmeyShip on PlayerShip movement.
  /// while it get touch with playerShip
  /// used on playerShip movement [updatePosition]
  /// * this method doesn't notify the update
  void _enemyCollisionChecker() {
    final enemyNotifier = ref.read(enemyProvider);
    List<EnemyShip> removeableEnemy = [];
    for (final enemy in enemyNotifier.enemies) {
      /// we can also use
      /// collisionChecker(a: enemy, b: player.bottomPart) || collisionChecker(a: enemy, b: player.topPart))
      if (collisionChecker(a: enemy, b: player)) removeableEnemy.add(enemy);
    }
    enemyNotifier.removeEnemies(ships: removeableEnemy);
    // no need to notify, `removeEnemies` handle this;
  }

  /// realTime Collision between HealthBox and Player movement
  /// value will be notifiyed by inner or outine the method
  /// * this method doesn't notify the update
  void _healthBoxCollision() {
    final healthBoxNotifier = ref.read(healingObjectProvider);

    List<GeneralHealingBox> removeableBox = [];

    for (final hb in healthBoxNotifier.healingBoxes) {
      if (collisionChecker(a: hb, b: player)) {
        player.health = GeneralHealingBox(iShipHealth: player.health);
        removeableBox.add(hb);
      }
    }
    healthBoxNotifier.removeBox(healingBox: removeableBox);
  }

  /// realTime Collision between Enemy's bullets and Player movement
  /// * this method doesn't notify the update
  void _enemyBulletCollision() {
    final enemyNotifier = ref.read(enemyProvider);

    final List<IBullet> removeableBullet = [];

    for (final bullet in enemyNotifier.bullets) {
      if (collisionChecker(a: bullet, b: player)) {
        removeableBullet.add(bullet);
      }
    }
    enemyNotifier.removeBullets(bullets: removeableBullet);
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
    stopShooting();
  }

  /// start player bullets movement
  payingMode() {
    _bulletsMovement();
    // todo: set controller for touch and keyboard mode; disable on touch mode
    startShooting();
    // debugPrint("playerProvider: PlayingMode");
    // debugPrint("BulletMovement Timer ${_timerBulletMovement == null}");
  }
}
