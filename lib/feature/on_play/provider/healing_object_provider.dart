import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector2/vector2.dart';

import '../../../core/entities/entities.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/utils.dart';
import '../models/models.dart';
import 'provider.dart';

final healingObjectProvider = ChangeNotifierProvider(
  (ref) {
    return Health(ref: ref);
  },
);

class Health extends ChangeNotifier implements GameState {
  final ChangeNotifierProviderRef ref;

  /// Healing Objects for [PlayerHealthManager], >> [IShipHealth]
  final List<GeneralHealingBox> _healingBoxes = [];

  List<GeneralHealingBox> get healingBoxes => [..._healingBoxes];

  /// boxGenerationRate depends on it
  Timer? _timerHealthBoxGeneration;

  ///box movement depends on it
  Timer? _timerBoxMovement;

  //todo: change health generation rate on release
  final Duration healthGenerateRate = const Duration(seconds: 5);
  final Duration healthBoxMovementRate = const Duration(milliseconds: 200);

  /// move down by  `_boxMovementY = 10.0` px
  final double _boxMovementY = 2.0;

  late final math.Random _random;
  Size? _screenSize;

  Size get screenSize => _screenSize ?? Size.zero;

  Health({
    required this.ref,
  }) : _random = math.Random();

  /// health box timer generator
  void _initGenerator() {
    if (_timerHealthBoxGeneration != null &&
        _timerHealthBoxGeneration!.isActive) {
      return;
    }

    // * generate healthBox per `healthGenerateRate`
    _timerHealthBoxGeneration = Timer.periodic(
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

  /// health boxes will move to Y axis
  void _boxMovement() {
    if (_timerBoxMovement != null && _timerBoxMovement!.isActive) return;

    _timerBoxMovement = Timer.periodic(
      healthBoxMovementRate,
      (timer) {
        if (healingBoxes.isEmpty) return;
        final playerRef = ref.read(playerInfoProvider);

        // collusion checking
        for (final box in healingBoxes) {
          box.position.update(dY: box.position.dY + _boxMovementY);
          //hit with PlayerShip, increase player health and remove box
          if (collisionChecker(a: playerRef.player, b: box)) {
            _healingBoxes.remove(box);
            playerRef.onEnergyHit();
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
  @override
  void onPause() {
    _timerHealthBoxGeneration?.cancel();
    _timerBoxMovement?.cancel();
  }

  @override
  void onPlay() {
    _initGenerator();
    _boxMovement();
  }

  @override
  void onReset() {
    // TODO: implement onReset
  }

  @override
  void onResume() {
    _initGenerator();
    _boxMovement();
  }

  @override
  void idle() {
    // TODO: implement onStart
  }

  @override
  void onStop() {
    // TODO: implement onStop
  }
}
