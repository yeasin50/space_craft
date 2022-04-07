import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../model/model.dart';
import '../screens/on_play/on_play.dart';
import 'provider.dart';

final healingObjectProvider = ChangeNotifierProvider(
  (ref) {
    return HealingObjectNotifier(ref: ref);
  },
);

class HealingObjectNotifier extends ChangeNotifier {
  final ChangeNotifierProviderRef ref;

  /// Healing Objects for [PlayerHealthManager], >> [IShipHealth]
  final List<GeneralHealingBox> _healingBoxes = [];

  List<GeneralHealingBox> get healingBoxes => [..._healingBoxes];

  /// boxGenerationRate depends on it
  Timer? _timerHealtBoxGeneration;

  ///box movement depends on it
  Timer? _timerBoxMovement;

  //todo: change healt generation rate on realease
  final Duration healthGenerateRate = const Duration(seconds: 5);
  final Duration healthBoxMovementRate = const Duration(milliseconds: 200);

  /// move down by  `_boxMovementY = 10.0` px
  final double _boxMovementY = 2.0;

  late final math.Random _random;
  Size? _screenSize;

  Size get screenSize => _screenSize ?? Size.zero;

  HealingObjectNotifier({
    required this.ref,
  }) : _random = math.Random();

  /// health box timer genertor
  void _initGenerator() {
    if (_timerHealtBoxGeneration != null &&
        _timerHealtBoxGeneration!.isActive) {
      return;
    }

    // * generate healthBox per `healthGenerateRate`
    _timerHealtBoxGeneration = Timer.periodic(
      healthGenerateRate,
      (timer) {
        _screenSize = ref.read(enemyProvider).screenSize;
        _healingBoxes.add(
          GeneralHealingBox(
            iShipHealth: ref.read(playerInfoProvider).shipHealthManager,
            initPos: Vector2(dX: _random.nextDouble() * screenSize.width),
          ),
        );

        notifyListeners();
        // debugPrint("numberOf healthBox: ${_healingBoxes.length}");
      },
    );
  }

  /// health boxes will move to Y asix
  void _boxMovement() {
    if (_timerBoxMovement != null && _timerBoxMovement!.isActive) return;

    _timerBoxMovement = Timer.periodic(
      healthBoxMovementRate,
      (timer) {
        if (healingBoxes.isEmpty) return;
        final playerRef = ref.read(playerInfoProvider);

        // collusion checking
        for (final box in healingBoxes) {
          box.position.copyWith(dY: box.position.dY + _boxMovementY);
          //hit with PlayerShip, increase player health and remove box
          if (collisionChecker(a: playerRef.player, b: box)) {
            _healingBoxes.remove(box);
            playerRef.updateHeathStatus(GeneralHealingBox);
          }

          // debugPrint(
          //     "boxPosY: ${box.position.dY} sHeight ${screenSize.height} ");
          // remove box while dY>screenSize.height
          if (box.position.dY > screenSize.height) {
            _healingBoxes.remove(box);
          }
        }
        notifyListeners();
      },
    );
  }

  /// remove `List<GeneralHealingBox>`  while it observed by player
  void removeBox({
    required List<GeneralHealingBox> healingBox,
  }) {
    _healingBoxes.removeAll(healingBox);
    notifyListeners();
  }

  //*---------------------------*
  //*       Controllers         *
  //*---------------------------*
  ///freeze the UI including healthBox generation
  void pauseMode() {
    _timerHealtBoxGeneration?.cancel();
    _timerBoxMovement?.cancel();
    // _timerHealtBoxGeneration = null;
    // _timerBoxMovement = null;
  }

  void playingMode() {
    _initGenerator();
    _boxMovement();
  }
}
