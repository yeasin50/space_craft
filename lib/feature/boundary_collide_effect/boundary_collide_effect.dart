import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'providers/collide_effect_provider.dart';
import 'widgets/widgets.dart';

class BoundaryGlowEffect extends StatelessWidget {
  const BoundaryGlowEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final collideInfo = ref.watch(playerBoundaryCollisionProvider);

        debugPrint(collideInfo.collideSides.toString());
        return Stack(
          children: [
            if (collideInfo.collideSides.contains(BoundarySide.left))
              GlowEffect(
                  key: const ValueKey("left-boundary-GlowEffect"),
                  effectNotifier: collideInfo,
                  side: BoundarySide.left),
            if (collideInfo.collideSides.contains(BoundarySide.top))
              GlowEffect(
                  key: const ValueKey("top-boundary-GlowEffect"),
                  effectNotifier: collideInfo,
                  side: BoundarySide.top),
            if (collideInfo.collideSides.contains(BoundarySide.right))
              GlowEffect(
                  key: const ValueKey("right-boundary-GlowEffect"),
                  effectNotifier: collideInfo,
                  side: BoundarySide.right),
            if (collideInfo.collideSides.contains(BoundarySide.bottom))
              GlowEffect(
                key: const ValueKey("bottom-boundary-GlowEffect"),
                effectNotifier: collideInfo,
                side: BoundarySide.bottom,
              ),
          ],
        );
      },
    );
  }
}
