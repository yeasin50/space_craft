import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

/// [MagicBall] animate particles from center, keep creation on every `blustDelay`

/// default constructor for MagicBall
/// ```
/// const MagicBall(
///     radius: 150,
///     numberOfParticles: 10,
///     blustDelay: Duration(milliseconds: 400),
///   ),
/// ```

/// [MagicBall.singleBlust] generate `numberOfParticles:10` only for single time
///
///```
/// const MagicBall.singleBlust(
///    blustDelay: Duration(milliseconds: 0),
///    numberOfParticles: 10,
///    radius: 150,
///   ),
///```
class MagicBall extends StatefulWidget {
  const MagicBall({
    Key? key,
    this.radius = 150,
    this.numberOfParticles = 10,
    this.blustDelay = const Duration(milliseconds: 400),
  })  : repeated = true,
        showRing = true,
        super(key: key);

  const MagicBall.singleBlust({
    Key? key,
    this.radius = 150,
    this.numberOfParticles = 10,
    this.blustDelay = const Duration(milliseconds: 0),
  })  : repeated = false,
        showRing = false,
        super(key: key);

  /// `showRign` is used to show the outter circle/ring. Only needed when showing magicBall or start screen
  /// `false` disable `decoration` on and used on ship destroy Effect
  ///  true for [MagicBall], false for [MagicBall.singleBlust]
  final bool showRing;

  /// used to create magicBall `Size(radius*2,radius*2)`
  final double radius;

  /// generate `numberOfParticles`  on  every blust
  final int numberOfParticles;

  /// Continuous particle creation on every `blustDelay`, default true for [MagicBall], false for [MagicBall.singleBlust]
  final bool repeated;

  /// repeated blust will generate on every `blustDelay`
  /// default  [MagicBall.singleBlust] `blustDelay` is `Duration(milliseconds: 0),` and [MagicBall] is 400 miliSec.
  final Duration blustDelay;

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

    widgetSize = Size(widget.radius * 2, widget.radius * 2);
    _timer = Timer.periodic(widget.blustDelay, (timer) {
      particles.addAll(
        List.generate(
          widget.numberOfParticles,
          (index) => ParticleWidget(
            key: ValueKey("P $idC $index"),
            id: idC++,
            parentSize: widgetSize,
            callback: _removeParticle,
          ),
        ),
      );

      //stop repeatation if `widget.repeated:false`
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
        alignment: Alignment.center,
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
          children: particles,
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

    animation =
        particleAnimation(controller: controller, size: widget.parentSize);

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
}
