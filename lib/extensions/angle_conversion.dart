import 'dart:math' as math;

extension AngleConversion<T extends num> on T {
  double get deg2rad => this * math.pi / 180;

  double get rad2deg => this * 180 / math.pi;
}
