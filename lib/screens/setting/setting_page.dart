import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static const String routeName = "/setting_page";

  @override
  Widget build(BuildContext context) {
    /// if needed to change BG
    return Scaffold(
      body: SettingView(),
    );
  }
}
