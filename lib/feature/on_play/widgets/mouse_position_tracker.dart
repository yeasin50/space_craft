import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MousePositionWrapper extends StatelessWidget {
  const MousePositionWrapper({
    super.key,
    required this.child,
    this.onHover,
  });

  final Widget child;
  final PointerHoverEventListener? onHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      child: child,
    );
  }
}
