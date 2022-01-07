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
            liveValue: sliderVal,
            height: 300,
          ),
        ],
      ),
    );
  }
}

class LiveBar extends StatefulWidget {
  final double height;
  final double liveValue;

  const LiveBar({
    Key? key,
    required this.height,
    required this.liveValue,
  }) : super(key: key);

  @override
  State<LiveBar> createState() => _LiveBarState();
}

class _LiveBarState extends State<LiveBar> with SingleTickerProviderStateMixin {
  late final Size paintSize;

  @override
  void initState() {
    paintSize = Size(widget.height, widget.height);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      child: Container(
        // color: Colors.cyanAccent.withOpacity(.3),
        width: paintSize.width * widget.liveValue + paintSize.height - 1,
        height: paintSize.height,
        child: CustomPaint(
          painter: HeartPainter(value: widget.liveValue),
        ),
      ),
    );
  }
}
