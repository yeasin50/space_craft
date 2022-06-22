import 'dart:async';

import 'package:flutter/material.dart';

///
/// {@tool snippet}
/// Create new GlitchController for [GlitchEffect] widget
///
/// * [duration] will be divided into tree part to show glitch effect.
///
/// * [repeatDelay] used to have periodic  glitch effect, default it is null and just provide single effect
///
///
/// ```
/// GlitchController({
///  this.duration = const Duration(milliseconds: 400),
///  this.repeatDelay,
///  })
/// ```
/// {@end-tool}
///
class GlitchController extends Animation<int>
    with
        AnimationEagerListenerMixin,
        AnimationLocalListenersMixin,
        AnimationLocalStatusListenersMixin {
  /// create a controller for single
  GlitchController({
    this.duration = const Duration(milliseconds: 400),
    this.repeatDelay,
  });

  final Duration duration;
  List<Timer> _timers = [];

  bool isAnimating = false;
  final Duration? repeatDelay;
 

  /// play glitch effect.
  void forward() {
    isAnimating = true;
    var oneStep = (duration.inMicroseconds / 3).round();
    _status = AnimationStatus.forward;
    _timers = [
      Timer(
        Duration(microseconds: oneStep),
        () => _setValue(1),
      ),
      Timer(
        Duration(microseconds: oneStep * 2),
        () => _setValue(2),
      ),
      Timer(
        Duration(microseconds: oneStep * 3),
        () => _setValue(3),
      ),
      Timer(
        Duration(microseconds: oneStep * 4),
        () {
          _status = AnimationStatus.completed;
          isAnimating = false;
          notifyListeners();
        },
      ),
    ];
  }

  void _setValue(value) {
    _value = value;
    notifyListeners();
  }

  void reset() {
    _status = AnimationStatus.dismissed;
    _value = 0;
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  AnimationStatus get status => _status;
  late AnimationStatus _status;

  @override
  int get value => _value;
  late int _value;
}
