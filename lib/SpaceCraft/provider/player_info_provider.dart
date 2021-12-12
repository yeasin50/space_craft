import 'package:flutter/cupertino.dart';

import '../../model/model.dart';

 

class Player {
  int _score = 0;
  int _health = 100;
  int _maxLive = 5;

  /// fire while player is alive and game is runnign
  bool shoot = false;

  ///current score of Player
  get score => _score;

  ///Player Health per life
  get health => _health;

  ///max number of time player can live
  get maxLive => _maxLive;

  double _height = 50;
  double _width = 50;

  //ship height =50
  get height => _height;
  //ship height =50
  get width => _width;

  Position2D position2d = Position2D(dX: 0, dY: 0);

  Player({
    position2d,
  });
}

///this provide Player UI update info
class PlayerInfoProvider extends ChangeNotifier {
  /// create player instance
  Player player = Player(
    position2d: Position2D(dX: 50, dY: 50),
  );

  /// update player vertical position
  void updateTopPosition(double dY) {
    player.position2d.dY = dY;
    notifyListeners();
  }

  ///update player horizontal position
  void updateLeftPosition(double dX) {
    player.position2d.dX = dX;
    notifyListeners();
  }

  /// increment score of player by destroying enemies
  void incrementScore() {
    player._score += 1;
    notifyListeners();
  }
}
