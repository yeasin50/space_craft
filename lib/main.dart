import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  //  //INIT MODULES
  //  Data.init();
  //  Domain.init();
  //  Presentation.init();
  //  //RUN APP
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
