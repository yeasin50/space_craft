import 'package:flutter/material.dart';

import '../../packages/packages.dart';
import 'start.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Responsive(
          mobile: MobileView(),
          tablet: TabletView(),
          desktop: DesktopView(),
        ),
      ),
    );
  }
}
