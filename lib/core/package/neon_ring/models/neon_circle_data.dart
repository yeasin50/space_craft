import 'package:flutter/material.dart';
/// [NeonCircleData] data used to decorate [NeonRingWidget]
/// ```
/// child: NeonRingWidget(
///   data:  NeonCircleData(size=16
///    ),
///  )
class NeonCircleData {
  ///Duration of animation default=`Duration(milliseconds: 150),` prefer 50 millisecond
  final Duration duration;

  final bool colorBlink;

  /// The Space between child and outer Container/frame known as NeonCircleBackground default is 9.0
  final double frameThickness;

  final double size;
  final List<Color> colors;

  /// default Curve= `Curves.ease`
  final Curve curve;

  /// rotate ring widget default is true
  final bool rotatable;

  /// rotate transform by  `rotationIncrementRate` degree on every [duration] while `rotation:true`
  /// default [rotationIncrementRate] is 5 degree
  final double rotationIncrementRateByDegree;

  final Widget? child;

  const NeonCircleData({
    this.colorBlink = false,
    required this.size,
    this.colors = const [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ],
    this.rotatable = true,
    this.curve = Curves.ease,
    this.rotationIncrementRateByDegree = 5.0,
    this.frameThickness = 9.0,
    this.duration = const Duration(milliseconds: 150),
    this.child,
  });

  NeonCircleData copyWith({
    Duration? duration,
    bool? colorBlink,
    double? frameThickness,
    double? size,
    List<Color>? colors,
    Curve? curve,
    bool? rotatable,
    double? rotationIncrementRateByDegree,
    Widget? child,
  }) {
    return NeonCircleData(
      duration: duration ?? this.duration,
      colorBlink: colorBlink ?? this.colorBlink,
      frameThickness: frameThickness ?? this.frameThickness,
      size: size ?? this.size,
      colors: colors ?? this.colors,
      curve: curve ?? this.curve,
      rotatable: rotatable ?? this.rotatable,
      rotationIncrementRateByDegree:
          rotationIncrementRateByDegree ?? this.rotationIncrementRateByDegree,
      child: child ?? this.child,
    );
  }

  @override
  String toString() {
    return 'NeonCircleData(duration: $duration, colorBlink: $colorBlink, frameThickness: $frameThickness, size: $size, colors: $colors, curve: $curve, rotatable: $rotatable, rotationIncrementRateByDegree: $rotationIncrementRateByDegree, child: $child)';
  }
}
