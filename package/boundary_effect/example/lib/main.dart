import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'example1.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: Builder(
          builder: (context) => ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: BoundaryEffectExample1(),
          ),
        ),
      ),
    ),
  );
}
