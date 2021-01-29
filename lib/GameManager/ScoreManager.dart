import 'package:flutter/material.dart';

class ScoreManager  with ChangeNotifier{
  int _score = 0;
  final _shipPerDestroy = 1;
  final _bossShipDestroy = 5;

  get score => _score;

  //Normal ship destroy
  incrementScore() {
    _score += _shipPerDestroy;
  }
}
