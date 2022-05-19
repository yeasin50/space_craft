// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../../provider/provider.dart';
// import '../utils/utils.dart';

// class KeyBoardListnerWrapper extends StatelessWidget {
//   KeyBoardListnerWrapper({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   final FocusNode focusNode = FocusNode();
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return RawKeyboardListener(
//       focusNode: focusNode,
//       onKey: (rawKeyEvent) {
//         if (rawKeyEvent is RawKeyDownEvent) {
//           keyboardMovementHandler(
//             event: rawKeyEvent,
//             constraints: constraints,
//             playerInfoNotifier: playerInfoNotifier,
//           );
//         }
//       },
//       child: child,
//     );
//   }
// }
