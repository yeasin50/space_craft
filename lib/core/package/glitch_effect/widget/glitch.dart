import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'glitch_controller.dart';

class GlitchEffect extends StatefulWidget {
  const GlitchEffect({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _GlitchEffectState createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late GlitchController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = GlitchController(
      duration: const Duration(
        milliseconds: 400,
      ),
    );

    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) {
        _controller
          ..reset()
          ..forward();
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  getRandomColor() => [
        Colors.blueAccent,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.orange,
      ][math.Random().nextInt(3)];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          var color = getRandomColor().withOpacity(0.5);
          if (!_controller.isAnimating) {
            return widget.child;
          }
          return Stack(
            children: [
              if (random.nextBool()) _clippedChild,
              Transform.translate(
                offset: randomOffset,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[
                        color,
                        color,
                      ],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: _clippedChild,
                ),
              ),
            ],
          );
        });
  }

  Offset get randomOffset => Offset(
        (random.nextInt(10) - 5).toDouble(),
        (random.nextInt(10) - 5).toDouble(),
      );
  Widget get _clippedChild => ClipPath(
        clipper: GlitchClipper(),
        child: widget.child,
      );
}

var random = math.Random();

class GlitchClipper extends CustomClipper<Path> {
  final deltaMax = 15;
  final min = 3;

  @override
  getClip(Size size) {
    var path = Path();
    var y = randomStep;
    while (y < size.height) {
      var yRandom = randomStep;
      var x = randomStep;

      while (x < size.width) {
        var xRandom = randomStep;
        path.addRect(
          Rect.fromPoints(
            Offset(x, y.toDouble()),
            Offset(x + xRandom, y + yRandom),
          ),
        );
        x += randomStep * 2;
      }
      y += yRandom;
    }

    path.close();
    return path;
  }

  double get randomStep => min + random.nextInt(deltaMax).toDouble();

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
