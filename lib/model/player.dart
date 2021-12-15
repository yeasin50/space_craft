import 'model.dart';

class Player {
  ///current score of Player
  final int score;

  ///Player Health per life
  final int health;

  ///max number of time player can live
  final int maxLive;

  /// fire while player is alive and game is runnign
  bool shoot;

  //ship height =50
  final double height;
  //ship height =50
  final double width;

  Vector2 position2d = Vector2(dX: 50, dY: 50);
  Player({
    this.score = 0,
    this.health = 100,
    this.maxLive = 3,
    this.height = 50,
    this.width = 50,
    this.shoot = false,
  });
}
