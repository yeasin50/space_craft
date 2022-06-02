import 'package:flutter/material.dart';

import '../../feature/on_play/on_play.dart';
import '../../feature/start/start.dart';


class AppRotue {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const StartScreen());

      case OnPlayScreen.routeName:
        return _materialRoute(const OnPlayScreen());

      default:
        return _materialRoute(const StartScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
