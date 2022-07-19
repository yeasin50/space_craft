import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/collide_effect_provider.dart';
import 'widgets/glow_effect.dart';

class BoundaryGlowEffect extends StatelessWidget {
  const BoundaryGlowEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final collideInfo = ref.watch(playerBoundaryCollisionProvider);

        return Stack(
          children: [
            if (collideInfo.collideSides.contains(BoundarySide.left))
              const GlowEffect(
                  key: ValueKey("left-boundary-GlowEffect"),
                  side: BoundarySide.left),

            if (collideInfo.collideSides.contains(BoundarySide.top))
              const GlowEffect(
                  key: ValueKey("top-boundary-GlowEffect"),
                  side: BoundarySide.top),

            if (collideInfo.collideSides.contains(BoundarySide.right))
              const GlowEffect(
                  key: ValueKey("right-boundary-GlowEffect"),
                  side: BoundarySide.right),

            if (collideInfo.collideSides.contains(BoundarySide.bottom))
              const GlowEffect(
                  key: ValueKey("bottom-boundary-GlowEffect"),
                  side: BoundarySide.bottom),

            //point
            if (collideInfo.collidePoint != null)
              Positioned(
                top: collideInfo.collidePoint!.dY,
                left: collideInfo.collidePoint!.dX,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              )
          ],
        );
      },
    );
  }
}
