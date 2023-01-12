import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vector2/vector2.dart';

import '../../core/entities/entities.dart';
import '../../core/providers/providers.dart';
import '../../core/widget/player_ship.dart';
import '../../core/widget/widget.dart';
import '../on_play/models/models.dart';
import '../on_play/on_play.dart';
import 'home_page.dart';

class PresentModePage extends StatelessWidget {
  const PresentModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (_, constraints) {
            // better to use constraints here
            final labels = [
              "",
              "Player Ship",
              "Bullet",
              for (int i = 0; i < ShipName.values.length - 1; i++)
                ShipName.values.elementAt(i + 1).name,
              ""
            ];
            final List<Widget> items = [
              const StartPageAnimation(),
              const _PresentModeShip(),
              const BulletWidget(
                bulletHeight: 50,
                color: Colors.cyanAccent,
                downward: false,
              ),
              ...[
                for (int i = 0; i < ShipName.values.length - 2; i++)
                  _EnemyShipOnPresentation(
                      enemyName: ShipName.values.elementAt(i + 1))
              ],
              const AnimatedEnemyShipA(size: Size.square(225)),
            ];

            return PageView(
              children: List.generate(
                items.length,
                (index) => Stack(
                  children: [
                    Center(child: items[index]),
                    Align(
                        alignment: Alignment(0, .65),
                        child: _buildName(labels[index])),
                  ],
                ),
              )
                ..addAll(
                  [
                    const _HealerPresentation(),
                  ],
                )
                ..toList(),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildName(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
    ),
  );
}

class _PresentModeShip extends StatelessWidget {
  const _PresentModeShip({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: PlayerShip(
            size: Size(
          GObjectSize.instance.playerShip.width * 4,
          GObjectSize.instance.playerShip.height * 4,
        )),
      ),
    );
  }
}

class _HealerPresentation extends StatefulWidget {
  const _HealerPresentation({super.key});

  @override
  State<_HealerPresentation> createState() => _HealerPresentationState();
}

class _HealerPresentationState extends State<_HealerPresentation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          })
          ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final itemSize = const Size.square(225);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: itemSize,
              willChange: true,
              painter: HeartPainter(value: animation.value),
              child: Container(
                width: itemSize.width,
                height: itemSize.height,
                alignment: Alignment.center,
                child: _buildName((100 * animation.value).toStringAsFixed(0)),
              ),
            ),
            _buildName("Live Paint")
          ],
        ),
        const SizedBox(width: 24),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotateWidget(
              //not using animated Value for heavy🤔
              child: CustomPaint(
                size: itemSize,
                willChange: true,
                painter: HeartPainter.radial(animationValue: animation.value),
                child: Container(
                  width: itemSize.width,
                  height: itemSize.height,
                  alignment: Alignment.center,
                  child: _buildName("10"),
                ),
              ),
            ),
            _buildName("Healing Box")
          ],
        ),
      ],
    );
  }
}

class _EnemyShipOnPresentation extends StatefulWidget {
  final ShipName enemyName;

  const _EnemyShipOnPresentation({
    super.key,
    required this.enemyName,
  });

  @override
  State<_EnemyShipOnPresentation> createState() =>
      _EnemyShipOnPresentationState();
}

class _EnemyShipOnPresentationState extends State<_EnemyShipOnPresentation> {
  ShipImageState state = ShipImageState.a;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      state == ShipImageState.a
          ? state = ShipImageState.b
          : state = ShipImageState.a;
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnemyShipWidget(
      ship: EnemyShip(
        position: Vector2(),
        name: widget.enemyName,
        imageState: state,
      )..size = const Size(48 * 5, 32 * 5),
    );
  }
}
