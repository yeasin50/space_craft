// import 'package:flutter/material.dart';

// import '../../core/package/magic_ball/magic_ball.dart';

// class AnimatedMagicBallX extends ImplicitlyAnimatedWidget {
//   const AnimatedMagicBallX({
//     Key? key,
//     required this.maxSize,
//     required this.child,
//     required Duration duration,
//     Curve curve = Curves.linear,
//     VoidCallback? onEnd,
//   }) : super(
//           key: key,
//           duration: duration,
//         );

//   final double maxSize;

//   /// The widget below this widget in the tree.
//   ///
//   /// {@macro flutter.widgets.ProxyWidget.child}
//   final Widget? child;

//   @override
//   ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
//       AnimatedMagicBallXState();
// }

// class AnimatedMagicBallXState
//     extends ImplicitlyAnimatedWidgetState<AnimatedMagicBallX> {
//   AnimationController? radiusController;
//   Tween<double>? ringAnimation;

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: ringAnimation,
//       child: MagicBall(
//         key: const ValueKey("MagicBall widget key"),
//         // size: widget.maxSize,
//       ),
//     );
//   }

//   @override
//   void forEachTween(TweenVisitor visitor) {
//     _opacity = visitor(_opacity, widget.opacity, (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;

//   }
// }
