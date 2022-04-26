import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  GlassMorphism({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
    BorderRadius? borderRadius,
  })  : _borderRadius = borderRadius ?? BorderRadius.circular(12),
        super(key: key);

  final double blur;
  final double opacity;
  final Widget child;

  final BorderRadius _borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: _borderRadius,
            border: Border.all(
              color: Colors.white.withOpacity(.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
