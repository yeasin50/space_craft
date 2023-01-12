part of neon_ring;

/// draw path like o with , used [CustomClipper]<[Path]>
class RingPath extends CustomClipper<Path> {
  /// ring/border thickness, default  it will be 16px [borderThickness].
  final double borderThickness;

  RingPath({
    this.borderThickness = 16,
  });

  @override
  Path getClip(Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final radius = size.width / 2;
    Path path1 = Path();
    path1.fillType = PathFillType.evenOdd;
    path1.addOval(Rect.fromCircle(center: center, radius: radius));
    path1.addOval(
        Rect.fromCircle(center: center, radius: radius - borderThickness));

    return path1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
