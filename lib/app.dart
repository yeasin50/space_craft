import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:space_craft/feature/on_play/on_play.dart';

import 'core/providers/object_scalar.dart';
import 'core/routes/app_routes.dart';
import 'core/themes/app_theme.dart';
import 'feature/animation_test/parent_glitch_test.dart';
import 'feature/home/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: kProfileMode,
      theme: AppTheme.light,
      onGenerateRoute: AppRoute.onGenerateRoutes,
      home: LayoutBuilder(
        builder: (context, constraints) {
          GObjectSize.init(
            size: Size(constraints.maxWidth, constraints.maxHeight),
          );
          return const HomePage();
        },
      ),
    );
  }
}
