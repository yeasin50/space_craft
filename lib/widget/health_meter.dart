import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HealthMeter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (ctx, data, ch) => Container(
        margin: EdgeInsets.symmetric(vertical: 25),
        child: LinearProgressIndicator(
          value: .01,
          backgroundColor: Colors.yellow,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
