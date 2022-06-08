import 'package:flutter/material.dart';

import '../../core/widget/widget.dart';
import 'widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static const String routeName = "/setting_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   dialogVibilityNotifier.value = !dialogVibilityNotifier.value;
      // }),
      body: Stack(
        children: const [
          Align(
            alignment: Alignment(.3, -.9),
            child: RotateWidget(
              rotateAxis: [true, true, true],
              repeat: true,
              reverseOnRepeat: false,
              child: RotationalBlastRing(
                radius: 150,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SettingDialogWidget(),
          ),
        ],
      ),
    );
  }
}
