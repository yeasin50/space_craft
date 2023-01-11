part of boundary_effect;

class GlowEffect extends StatelessWidget {
  final BoundarySide side;
  final double thickness;
  final Vector2 playerPosition;
  const GlowEffect({
    Key? key,
    required this.side,
    this.thickness = 16,
    required this.playerPosition,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    double? top, left, bottom, right;
    double? height, width;

    final Vector2 point = playerPosition;

    switch (side) {
      case BoundarySide.top:
        top = 0;
        left = 0;
        right = 0;
        height = thickness;
        break;
      case BoundarySide.right:
        top = 0;
        right = 0;
        bottom = 0;
        width = thickness;
        break;
      case BoundarySide.bottom:
        bottom = 0;
        left = 0;
        right = 0;
        height = thickness;
        break;
      case BoundarySide.left:
        left = 0;
        top = 0;
        bottom = 0;
        width = thickness;
        break;
      default:
    }

    debugPrint(point.toString());
    return Stack(
      key: const Key("_GlowEffectState"),
      children: [
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          height: height,
          width: width,
          child: GlowingContainer(
            side: side,
            center: playerPosition,
          ),
        ),
        //todo, use align/provide positioned value else it will block UI
        // Positioned(
        //   left: point.dX,
        //   top: point.dY,
        //   height: height ?? width ?? 0 * .2,
        //   width: height ?? width ?? 0 * .2,
        //   key: const ValueKey("point "),
        //   child: Container(
        //     color: Colors.green,
        //   ),
        // ),
      ],
    );
  }
}
