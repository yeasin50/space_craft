import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/glitch.dart';

class GlitchExample extends StatefulWidget {
  GlitchExample({Key? key}) : super(key: key);

  @override
  State<GlitchExample> createState() => _GlitchExampleState();
}

class _GlitchExampleState extends State<GlitchExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          GlitchEffect(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.cyanAccent,
              child: Text("This is e"),
            ),
          )
        ],
      ),
    );
  }
}
