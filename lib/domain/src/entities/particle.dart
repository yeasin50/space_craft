import 'package:flutter/material.dart';

class PVector {
  double x, y;
  PVector(this.x, this.y);
}

const double kheigth = 100;
const double kwidth = 100;
const double kbrustMovement = 5;
const int kbrustDuration = 100; // frameBuilder
const int kamountOfParticle = 8; // dont change it or edit frameBuilder

class Particle {
  PVector position = PVector(0.0, 0.0);
  Color color;
  double radius = 10;
  Particle({
    this.color = Colors.black38,
  });
}
