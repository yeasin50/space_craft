abstract class IPlayerScore {
  int score();
}

class EnemyShipDestroyScore implements IPlayerScore {
  IPlayerScore playerScore;

  final int increaseScore = 5;

  EnemyShipDestroyScore({
    required this.playerScore,
  });

  @override
  int score() => playerScore.score() + increaseScore;
}

class EnemyControllerScore implements IPlayerScore {
  IPlayerScore playerScore;
  final int increaseScore = 10;

  EnemyControllerScore({
    required this.playerScore,
  });

  @override
  int score() => playerScore.score() + increaseScore;
}

class PlayerScoreManager implements IPlayerScore {
  @override
  int score() {
    return 0;
  }
}
