import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({
    Key? key,
    this.size = const Size(300, 300),
  }) : super(key: key);

  final Size size;
  @override
  _MagicBallState createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> {
  List<Particle> particles = [];

  int idC = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      particles.addAll(
        List.generate(
          11,
          (index) => Particle(
            key: ValueKey("${index + idC}"),
            id: (index + idC++).toInt(),
            parentSize: widget.size,
            callback: () {
              particles.removeWhere(
                (element) => element.id == (index + idC).toInt(),
              );
              setState(() {});
            },
          ),
        ),
      );
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

class Particle extends StatefulWidget {
  final int id;
  const Particle({
    Key? key,
    required this.id,
    required this.parentSize,
    required this.callback,
  }) : super(key: key);

  // separate animation for each particle
  final Size parentSize;

  /// remove particle on animation end
  final Function callback;

  @override
  State<Particle> createState() => _ParticleState();
}

class _ParticleState extends State<Particle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  final Random random = Random();

  /// define direction of particle
  Offset endOffSet() {
    final randomHeight = random.nextDouble() * widget.parentSize.width / 2;
    final randomWidth = random.nextDouble() * widget.parentSize.height / 2;

    return Offset(
      random.nextDouble() > .5 ? randomWidth : 0,
      random.nextDouble() > .5 ? randomHeight : 0,
    );
  }

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
          widget.callback();
        }
      });

    animation = Tween<Offset>(
      begin: Offset(widget.parentSize.width / 2, widget.parentSize.height / 2),
      end: endOffSet(),
    ).animate(controller);

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
