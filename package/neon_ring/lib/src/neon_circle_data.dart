part of neon_ring;

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

  final EdgeInsets padding;

  /// The Space between child and outer Container/frame known as NeonCircleBackground default is 16.0
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
    this.padding = const EdgeInsets.all(8.0),
    this.colors = const [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ],
    this.rotatable = true,
    this.curve = Curves.ease,
    this.rotationIncrementRateByDegree = 5.0,
    this.frameThickness = 16.0,
    this.duration = const Duration(milliseconds: 150),
    this.child,
  });

  NeonCircleData copyWith({
    Duration? duration,
    bool? colorBlink,
    EdgeInsets? padding,
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
      padding: padding ?? this.padding,
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
    return 'NeonCircleData(duration: $duration, colorBlink: $colorBlink, padding: $padding, frameThickness: $frameThickness, size: $size, colors: $colors, curve: $curve, rotatable: $rotatable, rotationIncrementRateByDegree: $rotationIncrementRateByDegree, child: $child)';
  }
}
