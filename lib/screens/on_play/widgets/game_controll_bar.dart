import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../provider/provider.dart';

class GameControllBar extends ConsumerWidget {
  const GameControllBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final GameMode gameMode = ref.watch(gameManagerProvider);
    final GameManager gameModeNofitifer =
        ref.read(gameManagerProvider.notifier);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$gameMode"),
          InkWell(
            onTap: () {
              gameModeNofitifer.started();
            },
            child: const Text("started"),
          ),
          InkWell(
            onTap: () {
              gameModeNofitifer.paused();
            },
            child: const Text("paused"),
          ),
          InkWell(
            onTap: () {
              gameModeNofitifer.playing();
            },
            child: const Text("playing"),
          ),
        ],
      ),
    );
  }
}
