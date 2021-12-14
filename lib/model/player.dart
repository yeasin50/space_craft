import 'dart:convert';

import 'model.dart';

class Player {
  ///current score of Player
  final int score;

  ///Player Health per life
  final int health;

  ///max number of time player can live
  final int maxLive;

  /// fire while player is alive and game is runnign
  final bool shoot;

  //ship height =50
  final double height;
  //ship height =50
  final double width;

  final Vector2 position2d;
  Player({
    this.score = 0,
    this.health = 100,
    this.maxLive = 3,
    this.height = 50,
    this.width = 50,
    this.shoot = false,
    this.position2d = const Vector2(dX: 50, dY: 50),
  });

  Player copyWith({
    int? score,
    int? health,
    int? maxLive,
    bool? shoot,
    double? height,
    double? width,
    Vector2? position2d,
  }) {
    return Player(
      score: score ?? this.score,
      health: health ?? this.health,
      maxLive: maxLive ?? this.maxLive,
      shoot: shoot ?? this.shoot,
      height: height ?? this.height,
      width: width ?? this.width,
      position2d: position2d ?? this.position2d,
    );
  }
}
