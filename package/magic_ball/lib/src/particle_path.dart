part of magic_ball;


/// ParticlePathClipper used to show on magicBall and ship destroy effect
class ParticlePathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width / 2, 0)
    ..lineTo(size.width * .6, size.height * .4)
    ..lineTo(size.width, size.height * .5)
    ..lineTo(size.width * .6, size.height * .6)
    ..lineTo(size.width / 2, size.height)
    ..lineTo(size.width * .4, size.height * .6)
    ..lineTo(0, size.height / 2)
    ..lineTo(size.width * .4, size.height * .4);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// Path to draw star:old;
/// ClipPath(clipper: StarPathClipper(),..)
class _StarPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * .25, size.height * .9)
    ..lineTo(size.width * .5, 0)
    ..lineTo(size.width * .85, size.height * .9)
    ..lineTo(size.width * .05, size.height * .3)
    ..lineTo(size.width * .95, size.height * .3)
    ..lineTo(size.width * .25, size.height * .9);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

/// perfect star path from SVG conversion using flutterShapeMaker
/// Use on CliPath
class StarPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * 0.5000000, size.height * 0.02445833)
    ..lineTo(size.width * 0.6528333, size.height * 0.3397917)
    ..lineTo(size.width, size.height * 0.3877500)
    ..lineTo(size.width * 0.7473333, size.height * 0.6305833)
    ..lineTo(size.width * 0.8090000, size.height * 0.9755417)
    ..lineTo(size.width * 0.5000000, size.height * 0.8102500)
    ..lineTo(size.width * 0.1909583, size.height * 0.9755417)
    ..lineTo(size.width * 0.2526667, size.height * 0.6305833)
    ..lineTo(0, size.height * 0.3877500)
    ..lineTo(size.width * 0.3471667, size.height * 0.3397917)
    ..close();
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
