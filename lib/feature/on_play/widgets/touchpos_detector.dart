import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../setting/providers/providers.dart';

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
          // onTap: () {
          //   // debugPrint("on onPanUpdate");
          // },
          onPanDown: (details) {
            updatePlayerPosition(widgetRef: ref, offset: details.localPosition);
            if (!SpaceInvaderSettingProvider.instance.freeFire) {
              playerInfo.startShooting();
            }
          },
          onTapUp: (_) {
            // handle quick tap up
            if (!SpaceInvaderSettingProvider.instance.freeFire) {
              playerInfo.stopShooting();
            }
          },
          onPanEnd: (_) {
            //handle drag tapUp
            if (!SpaceInvaderSettingProvider.instance.freeFire) {
              playerInfo.stopShooting();
            }
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
