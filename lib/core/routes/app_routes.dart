import 'package:flutter/material.dart';

import '../../feature/home/home_page.dart';
import '../../feature/on_play/on_play.dart';
import '../../feature/setting/setting.dart';

class AppRoute {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return _materialRoute(const HomePage());

      case OnPlayScreen.routeName:
        return _materialRoute(const OnPlayScreen());

      case SettingPage.routeName:
        return _materialRoute(const SettingPage());

      default:
        return _materialRoute(const HomePage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
