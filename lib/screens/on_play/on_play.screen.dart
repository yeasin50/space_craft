import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/provider.dart';
import 'widgets/widgets.dart';

class OnPlayScreen extends ConsumerWidget {
  const OnPlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerInfo = ref.watch(playerInfoProvider);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: playerInfo.player.position2d.dY,
            left: playerInfo.player.position2d.dX,
            child: playerShip(),
          ),
          ...playerInfo.bullets.map((b) {
            return Positioned(
              top: b.position.dY,
              left: b.position.dX,
              child: Text('A'),
            );
          }).toList(),

          /// detect touch on bottom
          const TouchPositionDetector(),
        ],
      ),
    );
  }
}
