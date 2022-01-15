import 'package:flutter/material.dart';

import '../../../provider/provider.dart';
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LiveBar(
          playerHealth: playerInfoNotifier.player.health.health(),
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
