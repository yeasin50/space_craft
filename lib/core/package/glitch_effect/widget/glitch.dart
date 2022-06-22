import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'glitch_controller.dart';

/// A widget that provide glitch effect for its [child]
///
/// Provide `[GlitchController]` on  `controller` parameters for customization
///
///```
///GlitchEffect(
///  child: Text("single Glitch effect Text"),
///  controller: GlitchController(),
///),
///```
///
/// To use periodic effect use [GlitchController] with providing `repeatDelay`
///
/// ```
/// GlitchEffect(
/// controller: GlitchController(
///   repeatDelay: const Duration(seconds: 2),
/// ),
/// child: Container(
///   height: 250,
///   width: 250,
///   color: Colors.green,
///  ))
/// ```
///
/// The main  glitch effect project is forked from kherel/flutter_fun and  can be found under https://github.com/yeasin50/flutter_fun
///

class GlitchEffect extends StatefulWidget {
  /// TODO: make package on gitRepo

  /// Create glitch effect for its [child]
  ///
  /// Provide `[GlitchController]` on  `controller` parameters for customization
  ///
  const GlitchEffect({
    Key? key,
    this.controller,
    required this.child,
  }) : super(key: key);

  final Widget child;

  final GlitchController? controller;

  @override
  _GlitchEffectState createState() => _GlitchEffectState();
}

class _GlitchEffectState extends State<GlitchEffect>
    with SingleTickerProviderStateMixin {
  late GlitchController _controller;
  Timer? _timer;

  final random = math.Random();

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? GlitchController();

    if (_controller.repeatDelay != null) {
      _timer = Timer.periodic(
        _controller.repeatDelay!,
        (_) {
          _controller
            ..reset()
            ..forward();
        },
      );
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

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
