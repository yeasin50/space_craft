import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({
    Key? key,
    this.radius = 150,
  }) : super(key: key);

  /// used to create magicBall `Size(radius*2,radius*2)`
  final double radius;

  /// generate [genaratePerBlust] [] after [blustDelay]
  final int genaratePerBlust = 10;
  final Duration blustDelay = const Duration(milliseconds: 400);

  @override
  _MagicBallState createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  List<ParticleWidget> particles = [];

  int idC = 0;
  late Timer _timer;

  late Size widgetSize;

  _removeParticle(int id) {
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
          widget.genaratePerBlust,
          (index) => ParticleWidget(
            key: ValueKey("P $idC $index"),
            id: idC++,
            parentSize: widgetSize,
            callback: _removeParticle,
          ),
        ),
      );
      idC += widget.genaratePerBlust;

      setState(() {});
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
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            Colors.transparent,
            Colors.lightBlueAccent.withOpacity(.5),
          ], stops: const [
            .8,
            1.0
          ]),
        ),
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
