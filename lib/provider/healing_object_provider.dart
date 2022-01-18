import 'dart:async';
import 'dart:html';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:space_craft/screens/on_play/on_play.dart';

import '../model/model.dart';
import 'provider.dart';

final healingObjectProvider = ChangeNotifierProvider((ref) {
  return HealingObjectNotifier(ref: ref);
});

class HealingObjectNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;

  /// Healing Objects for [PlayerHealthManager], >> [IShipHealth]
  final List<GeneralHealingBox> _healingBoxes = [];

  List<GeneralHealingBox> get healingBoxes => [..._healingBoxes];

  Timer? _timerHealtBoxGeneration;

  final Duration healthGenerateRate = const Duration(seconds: 1);

  /// move down by  `_boxMovementY = 10.0` px
  final double _boxMovementY = 10.0;

  late final Size _screenSize;
  late final math.Random _random;

  HealingObjectNotifier({
    required this.ref,
  })  : _random = math.Random(),
        _screenSize = ref.read(enemyProvider).screenSize;

  /// health box timer genertor
  void _initGenerator() {
    _timerHealtBoxGeneration = Timer.periodic(
      healthGenerateRate,
      (timer) {
        _healingBoxes.add(
          GeneralHealingBox(
            iShipHealth: ref.read(playerInfoProvider).shipHealthManager,
            initPos: Vector2(dX: _random.nextDouble() * _screenSize.width),
          ),
        );

        notifyListeners();
      },
    );
  }

  // health boxes will move to Y asix
  void _boxMovement() {
    if (healingBoxes.isEmpty) return;

    final playerRef = ref.read(playerInfoProvider);

    for (final box in healingBoxes) {
      box.position.dY += _boxMovementY;

      //hit with PlayerShip, increase player health and remove box
      if (collisionChecker(a: playerRef.player, b: box)) {
        _healingBoxes.remove(box);
        playerRef.updateHeathStatus(GeneralHealingBox);
      }

      // remove box while dY>screenSize.height
      if (box.position.dY > _screenSize.height) {
        _healingBoxes.remove(box);
      }
    }

    notifyListeners();
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*

}
