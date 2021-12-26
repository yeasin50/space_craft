import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/utils.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({
    Key? key,
    this.size = const Size(300, 300),
  }) : super(key: key);

  final Size size;

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
    _timer = Timer.periodic(widget.blustDelay, (timer) {
      particles.addAll(
        List.generate(
          widget.genaratePerBlust,
          (index) => ParticleWidget(
            key: ValueKey("P $idC $index"),
            id: idC++,
            parentSize: widget.size,
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
        width: widget.size.width,
        height: widget.size.height,
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
  final int id;
  const ParticleWidget({
    Key? key,
    required this.id,
    required this.parentSize,
    required this.callback,
  }) : super(key: key);

  // separate animation for each particle
  final Size parentSize;

  /// remove particle on animation end
  final Function(int) callback;

  @override
  State<ParticleWidget> createState() => _ParticleWidgetState();
}

class _ParticleWidgetState extends State<ParticleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

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

    // controller.repeat(reverse: true);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: animation.value.dx,
      top: animation.value.dy,
      child: Container(
        height: 5,
        width: 5,
        decoration: const BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
