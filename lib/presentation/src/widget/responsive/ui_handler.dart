import 'package:flutter/material.dart';

const double kMaxWidth = 1200.0;
const double kMobileMaxWidth = 650.0;
const double kTabletMaxWidth = 1100.0;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < kMobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < kTabletMaxWidth &&
      MediaQuery.of(context).size.width >= kMobileMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= kTabletMaxWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= kTabletMaxWidth) {
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= kMobileMaxWidth) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
