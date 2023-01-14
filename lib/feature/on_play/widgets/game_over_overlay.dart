import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/widget/widget.dart';
import '../../home/home_page.dart';
import '../provider/provider.dart';

class GameOverOverlay extends ConsumerWidget {
  const GameOverOverlay({super.key});

  static const TextStyle _textStyleTitle = TextStyle(
    color: Color.fromARGB(245, 252, 252, 252),
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context, ref) {
    final gameMode = ref.watch(gameManagerProvider);
    return gameMode != GamePlayState.over
        ? const SizedBox()
        : GlassMorphism(
            blur: 1,
            opacity: .4,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Game Over",
                    style: _textStyleTitle,
                  ),
                  Text(
                    "Score: ${ref.read(playerInfoProvider).scoreManager.score()}",
                    style: _textStyleTitle.copyWith(fontSize: 34),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 124,
                        child: CustomButton(
                          value: false,
                          defaultColor: const Color.fromARGB(137, 30, 80, 95),
                          text: "Restart",
                          callback: () {
                            ref.read(gameManagerProvider.notifier).onRestart();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 124,
                        child: CustomButton(
                          value: false,
                          defaultColor: const Color.fromARGB(106, 45, 55, 58),
                          text: "Close",
                          callback: () {
                            ref.read(gameManagerProvider.notifier).onExit();
                            Navigator.of(context)
                                .pushReplacementNamed(HomePage.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
