import 'package:flutter/material.dart';

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

///TODO: add more shapes