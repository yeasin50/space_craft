import 'package:flutter/material.dart';

import 'dart:math' as math;

Color getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.orange,
    ][math.Random().nextInt(4)];
