import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/clip_paths/particle_path.dart';

/// [MagicBall] animate particles from center, keep creation on every `blastDelay`

/// default constructor for MagicBall
/// ```
/// const MagicBall(
///     size: 150,
///     numberOfParticles: 10,
///     blastDelay: Duration(milliseconds: 400),
///   ),
/// ```

/// [MagicBall.singleBlast] generate `numberOfParticles:10` only for single time
///
///```
/// const MagicBall.singleBlast(
///    blastDelay: Duration(milliseconds: 0),
///    numberOfParticles: 10,
///    size: 150,
///   ),
///```
class MagicBall extends StatefulWidget {
  const MagicBall({
    Key? key,
    this.size = 150,
    this.numberOfParticles = 10,
    this.blastDelay = const Duration(milliseconds: 400),
    this.child,
  })  : repeated = true,
        showRing = true,
        super(key: key);

  const MagicBall.singleBlast({
    Key? key,
    this.size = 150,
    this.numberOfParticles = 10,
    this.blastDelay = const Duration(milliseconds: 0),
    this.child,
  })  : repeated = false,
        showRing = false,
        super(key: key);

  /// `showRing` is used to show the outer circle/ring. Only needed when showing magicBall or start screen
  /// `false` disable `decoration` on and used on ship destroy Effect
  ///  true for [MagicBall], false for [MagicBall.singleBlast]
  final bool showRing;

  /// used to create magicBall ``
  final double size;

  /// generate `numberOfParticles`  on  every blast
  final int numberOfParticles;

  /// Continuous particle creation on every `blastDelay`, default true for [MagicBall], false for [MagicBall.singleBlast]
  final bool repeated;

  /// repeated blast will generate on every `blastDelay`
  /// default  [MagicBall.singleBlast] `blastDelay` is `Duration(milliseconds: 0),` and [MagicBall] is 400 millisecond.
  final Duration blastDelay;

  final Widget? child;

  @override
  _MagicBallState createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  List<ParticleWidget> particles = [];

  int idC = 0;

  //for repeated animation
  late Timer _timer;
  late Size widgetSize;

  /// remove particle when it reach the radius/border
  void _removeParticle(int id) {
    particles.removeWhere((element) {
      // debugPrint(
      //     " Gen:$idC state: ${element.id == id} totalParticles: ${particles.length}");
      return element.id == id;
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    widgetSize = Size.square(widget.size);
    _timer = Timer.periodic(widget.blastDelay, (timer) {
      final newParticles = List.generate(
        widget.numberOfParticles,
        (index) => ParticleWidget(
          key: ValueKey("ParticleWidget id$idC: index$index"),
          id: idC++,
          parentSize: widgetSize,
          callback: _removeParticle,
        ),
      );
      particles = [...particles, ...newParticles];
      //stop repetition if `widget.repeated:false`
      if (!widget.repeated) {
        timer.cancel();
      }
      idC += widget.numberOfParticles;
      setState(() {});
      // debugPrint("timer periodic: Particle id $idC");
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        //todo: fixing explosion position
        //* we can use `widget.showRing` or `widget.repeated` while both is false on [MagicBall.singleBlast()]
        width: widgetSize.width,
        height: widgetSize.height,
        decoration: widget.showRing
            ? BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.transparent,
                    Colors.lightBlueAccent.withOpacity(.5),
                  ],
                  stops: const [.8, 1.0],
                ),
              )
            : null,
        child: Stack(
          children: [
            ...particles,
            if (widget.child != null) widget.child!,
          ],
        ),
      ),
    );
  }
}

/// used on [MagicBall]
class ParticleWidget extends StatefulWidget {
  /// draw [particleSize] default Size(10,10), within [parentSize]
  final Size? particleSize;

  final int id;

  // separate animation for each particle
  final Size parentSize;

  /// remove particle on animation end
  final Function(int id) callback;

  const ParticleWidget({
    Key? key,
    required this.id,
    required this.parentSize,
    required this.callback,
    this.particleSize,
  }) : super(key: key);

  @override
  State<ParticleWidget> createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  final math.Random _random = math.Random();

  late Size particleSize;
  late Size parentSize;

  @override
  void initState() {
    super.initState();

    parentSize = widget.parentSize;
    particleSize = widget.particleSize ?? const Size(10, 10);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.callback(widget.id);
        }
      });

    animation = createParticleAnimation(
        controller: controller, size: widget.parentSize);

    // widget.debugMode ? controller.repeat() :
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("controller value: ${controller.value}");
    return Positioned(
      left: animation.value.dx,
      top: animation.value.dy,

      //todo: clipPath with animatedContainer(size)
      child: ClipPath(
        clipper: ParticlePathClipper(),
        child: Container(
          height: particleSize.height * controller.value,
          width: particleSize.width * controller.value,
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  /// define direction and end position of particle
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
  Animation<Offset> createParticleAnimation({
    required Size size,
    required AnimationController controller,
  }) {
    final of = _endOffSet(controller: controller, size: size);
    // debugPrint(of.toString());
    return Tween<Offset>(
      begin: Offset(size.width / 2, size.height / 2),
      end: of,
    ).animate(controller);
  }
}
