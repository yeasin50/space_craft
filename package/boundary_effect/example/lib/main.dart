import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'example1.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: BoundaryEffectExample1(),
      ),
    ),
  );
}
