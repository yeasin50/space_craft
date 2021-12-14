import 'dart:async';

import 'package:flutter/foundation.dart';

import '../model/model.dart';
import 'provider.dart';

final bulletsProvider = ChangeNotifierProvider<BulletsNotifier>(
  (ref) {
    final Player player = ref.watch(playerInfoProvider).player;
    return BulletsNotifier(player: player);
  },
);

class BulletsNotifier extends ChangeNotifier {
  final Player player;
  List<Bullet> bullets = [];

  final Duration bulletGenerateRate = const Duration(milliseconds: 100);
  Timer? _timer;

  BulletsNotifier({
    required this.player,
  }) {
    print(player.position2d.dX);
  }

  generatePlayerBullet() async {
    _timer = Timer.periodic(bulletGenerateRate, (t) {
      // _addPlayerBullet(playerPosition);
      print(
          "Start Bullet generation ${bullets.length} Px ${player.position2d.dX}");
    });
  }

  stopPlayerBulletGeneration() {
    if (_timer != null) _timer!.cancel();
    print("Stoped Bullet generation");
  }

  _addPlayerBullet(Vector2 position) {
    bullets.add(Bullet(position: position));
    notifyListeners();
  }

  removePlayerBullet(Bullet bullet) {
    bullets.remove(bullet);
    notifyListeners();
  }
}
