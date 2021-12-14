import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/provider.dart';
import 'widgets/widgets.dart';

class OnPlayScreen extends ConsumerWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfo = ref.watch(playerInfoProvider);
    return Stack(
      children: [
        Positioned(
          top: playerInfo.player.position2d.dY,
          left: playerInfo.player.position2d.dX,
          child: playerShip(),
        ),

        /// detect touch on bottom
        const TouchPositionDetector(),
      ],
    );
  }
}
