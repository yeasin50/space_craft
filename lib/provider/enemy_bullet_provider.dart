import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';

import '../model/model.dart';
import 'provider.dart';

/// enemy ship bullets
final bulletsProvider = ChangeNotifierProvider<BulletsNotifier>(
  (ref) {
    return BulletsNotifier();
  },
);

class BulletsNotifier extends ChangeNotifier {
  final Duration bulletGenerateRate = const Duration(milliseconds: 100);

  List<Bullet> bullets = [];

  CancelableOperation? _cancelableOperation;
  late Timer _timer;

  _bulletGeneration() {
    if (_cancelableOperation != null) {
      _cancelableOperation!.cancel();
    }

    _cancelableOperation = CancelableOperation.fromFuture(
      Future.delayed(bulletGenerateRate),
    ).then((p0) {
      _timer = Timer.periodic(bulletGenerateRate, (timer) {});
    }, onCancel: () {
      _timer.cancel();
    });
  }

  _addPlayerBullet(Vector2 position) {
    notifyListeners();
  }

  removePlayerBullet(Bullet bullet) {
    notifyListeners();
  }
}
