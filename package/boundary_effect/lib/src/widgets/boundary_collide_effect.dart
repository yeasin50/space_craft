part of boundary_effect;

class BoundaryGlowEffect extends StatelessWidget {
  const BoundaryGlowEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Consumer(
        builder: (context, ref, child) {
          final collideInfo = ref.watch(playerBoundaryCollisionProvider);
          collideInfo.init(
              size: Size(constraints.maxWidth, constraints.maxHeight));
          final playerPosition = collideInfo.collidePoint ?? Vector2();

          return Stack(
            children: [
              if (collideInfo.collideSides.contains(BoundarySide.left))
                GlowEffect(
                    key: const ValueKey("left-boundary-GlowEffect"),
                    playerPosition: playerPosition,
                    side: BoundarySide.left),
              if (collideInfo.collideSides.contains(BoundarySide.top))
                GlowEffect(
                    key: const ValueKey("top-boundary-GlowEffect"),
                    playerPosition: playerPosition,
                    side: BoundarySide.top),
              if (collideInfo.collideSides.contains(BoundarySide.right))
                GlowEffect(
                    key: const ValueKey("right-boundary-GlowEffect"),
                    playerPosition: playerPosition,
                    side: BoundarySide.right),
              if (collideInfo.collideSides.contains(BoundarySide.bottom))
                GlowEffect(
                  key: const ValueKey("bottom-boundary-GlowEffect"),
                  playerPosition: playerPosition,
                  side: BoundarySide.bottom,
                ),
            ],
          );
        },
      ),
    );
  }
}
