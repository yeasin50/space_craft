import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/provider.dart';
import '../utils/utils.dart';

//this widget gonna handle UI Touch Position
class TouchPositionDetector extends StatelessWidget {
  const TouchPositionDetector({
    Key? key,
    required this.constraints,
    this.child,
  }) : super(key: key);

  final BoxConstraints constraints;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final playerInfo = ref.read(playerInfoProvider);

        return GestureDetector(
          // behavior: HitTestBehavior.translucent,
          onTap: () {
            // debugPrint("on onPanUpdate");
          },
          onPanDown: (details) {
            updatePlayerPosition(widgetRef: ref, offset: details.localPosition);
          },
          onTapUp: (details) {
            // handle quick tap up
            playerInfo.stopShooting();
          },
          onPanEnd: (details) {
            //handle drag tapUp
            playerInfo.stopShooting();
          },
          onPanUpdate: (details) {
            updatePlayerPosition(widgetRef: ref, offset: details.localPosition);
          },
          child: child,
        );
      },
    );
  }
}
