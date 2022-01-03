import 'package:flutter/material.dart';
import 'package:space_craft/utils/utils.dart';

import 'package:space_craft/widget/magic_ball.dart';

import 'screens/on_play/on_play.screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _TestCases(),
      // OnPlayScreen(),
    );
  }
}

class _TestCases extends StatefulWidget {
  const _TestCases({Key? key}) : super(key: key);

  @override
  State<_TestCases> createState() => _TestCasesState();
}

class _TestCasesState extends State<_TestCases> {
  double sliderVal = .2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Slider(
            value: sliderVal,
            onChanged: (value) {
              setState(() {
                sliderVal = value;
              });
            },
          ),
          LiveBar(
            liveValue: sliderVal * 100,
          ),
        ],
      ),
    );
  }
}

class LiveBar extends StatefulWidget {
  const LiveBar({
    Key? key,
    required this.liveValue,
  }) : super(key: key);

  final double liveValue;

  @override
  State<LiveBar> createState() => _LiveBarState();
}

class _LiveBarState extends State<LiveBar> with SingleTickerProviderStateMixin {
  late Animation<Color> colorAnimation;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);

    TweenSequence(
      [
        TweenSequenceItem(
          tween: ColorTween(
            begin: Colors.redAccent,
            end: Colors.red.shade300,
          ),
          weight: 1,
        ),
      ],
    ).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: SizedBox(
        width: 400,
        height: 100,
        child: ColoredBox(
          color: Colors.grey,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(widget.liveValue.toStringAsFixed(0)),
              Align(
                alignment: const Alignment(-.95, 0),
                child: Icon(
                  Icons.favorite,
                  color: changeColorHue(
                      color: Colors.red, increaseBy: widget.liveValue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
