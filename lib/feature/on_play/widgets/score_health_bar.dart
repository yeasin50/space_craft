import 'package:flutter/material.dart';

import '../provider/player_info_provider.dart';
import 'heart_progress.dart';

class ScoreHealthBar extends StatelessWidget {
  final PlayerInfoNotifier playerInfoNotifier;
  final double heartHeight;
  const ScoreHealthBar({
    Key? key,
    required this.playerInfoNotifier,
    required this.heartHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double playerHealth = playerInfoNotifier.player.health.health();
    if (playerHealth < 0) playerHealth = 0;
    int score = playerInfoNotifier.scoreManager.score();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LiveBar(
          playerHealth: playerHealth,
        ),
        Text(
          "Health $playerHealth",
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          "Score: $score",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
