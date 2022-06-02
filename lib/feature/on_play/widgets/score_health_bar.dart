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
    final playerHealth = playerInfoNotifier.player.health.health();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LiveBar(
          playerHealth: playerHealth < 0 ? 0 : playerHealth,
        ),
        Text(
          "Health $playerHealth",
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          "Score: ${playerInfoNotifier.scoreManager.score()}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
