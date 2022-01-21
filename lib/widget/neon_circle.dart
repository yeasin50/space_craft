import 'package:flutter/material.dart';

import '../utils/utils.dart';

class NeonRingWidget extends StatelessWidget {
  const NeonRingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyanAccent.withOpacity(.3),
      child: ClipPath(
        clipper: RingPath(),
        child: Container(
          color: Colors.amber,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
