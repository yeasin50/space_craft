import 'package:flutter/material.dart';

import '../../../provider/provider.dart';

class ScoreHealthBar extends StatelessWidget {
  final PlayerInfoNotifier playerInfoNotifier;

  const ScoreHealthBar({
    Key? key,
    required this.playerInfoNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Score: ${playerInfoNotifier.scoreManager.score()}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
