import 'dart:math';

import 'package:flutter/material.dart';

final Random _random = Random();

/// define direction and end positon of particle
Offset _endOffSet({
  required Size size,
  required AnimationController controller,
}) {
  return Offset(
    _random.nextDouble() * size.width,
    _random.nextDouble() * size.height,
  );
}

/// generate [Animation] of [Offset] EndOffset of [MagicBall] [Particle]
Animation<Offset> particleAnimation({
  required Size size,
  required AnimationController controller,
}) {
  final of = _endOffSet(controller: controller, size: size);
  debugPrint(of.toString());
  return Tween<Offset>(
    begin: Offset(size.width / 2, size.height / 2),
    end: of,
  ).animate(controller);
}
