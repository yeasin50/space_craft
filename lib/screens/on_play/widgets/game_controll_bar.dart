import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../provider/provider.dart';

class GameControllBar extends ConsumerWidget {
  const GameControllBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final GameMode gameMode = ref.watch(gameManagerProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$gameMode"),
          InkWell(
            onTap: () {},
            child: const Text("started"),
          ),
          InkWell(
            onTap: () {},
            child: const Text("paused"),
          ),
          InkWell(
            onTap: () {
              ref.read(enemyProvider).generateEnemies();
            },
            child: const Text("playing"),
          ),
        ],
      ),
    );
  }
}
