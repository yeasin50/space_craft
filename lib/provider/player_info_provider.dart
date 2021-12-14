import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model.dart';

final playerInfoProvider = ChangeNotifierProvider<PlayerInfoNotifier>(
  (ref) {
    return PlayerInfoNotifier();
  },
);

///this provide Player UI update info
class PlayerInfoNotifier extends ChangeNotifier {
  /// create player instance
  Player player = Player(
    position2d: const Vector2(dX: 50, dY: 50),
  );

  /// update player vertical position
  void updateTopPosition(double dY) {
    player = player.copyWith(
      position2d: player.position2d.copyWith(
        dY: dY,
      ),
    );
    notifyListeners();
  }

  ///update player horizontal position
  void updateLeftPosition(double dX) {
    player = player.copyWith(
      position2d: player.position2d.copyWith(
        dX: dX,
      ),
    );
    notifyListeners();
  }

  void startShooting() {
    player.copyWith(shoot: true);
    notifyListeners();
  }

  void stopShooting() {
    player.copyWith(shoot: false);
    notifyListeners();
  }

  /// increment score of player by destroying enemies
  void incrementScore() {
    // player._score += 1;
    notifyListeners();
  }
}
