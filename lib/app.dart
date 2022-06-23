import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'core/package/glitch_effect/example/gitch_example.dart';
import 'core/themes/app_theme.dart';
import 'feature/home/home_page.dart';
import 'core/providers/object_scalar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: kProfileMode,
      theme: AppTheme.light,
      home: LayoutBuilder(
        builder: (context, constraints) {
          GObjectSize.init(
              size: Size(constraints.maxWidth, constraints.maxHeight));
          return const HomePage();
        },
      ),
    );
  }
}
