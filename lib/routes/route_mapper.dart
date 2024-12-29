import 'package:flutter/cupertino.dart';
import 'package:routing_app/routes/route_config.dart';

import '../ui/screens/authentication_screen.dart';
import '../ui/screens/counter_screen.dart';
import '../ui/screens/screen_default.dart';

class RouteMapper {
  static Widget getRoute(String routeName, Map<String, dynamic> args) {
    switch (routeName) {
      case RouteConfig.counter:
        return const CounterScreen();
      case RouteConfig.authentication:
        return const AuthenticationScreen();
      default:
        return const ScreenDefault();
    }
  }
}
