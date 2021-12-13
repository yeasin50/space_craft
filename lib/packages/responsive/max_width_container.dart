import 'package:flutter/material.dart';

import 'ui_handler.dart';

class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: kMaxWidth,
        ),
        child: child,
      ),
    );
  }
}
