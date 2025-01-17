import 'package:flutter/cupertino.dart';
import 'package:routing_app/routes/route_config.dart';
import 'package:routing_app/ui/screens/home_screen.dart';

import '../ui/screens/authentication_screen.dart';
import '../ui/screens/screen_default.dart';

class RouteMapper {
  static Widget getRoute(String routeName, Map<String, dynamic> args) {
    switch (routeName) {
      case RouteConfig.home:
        return const HomeScreen();
      case RouteConfig.authentication:
        return const AuthenticationScreen();
      default:
        return const ScreenDefault();
    }
  }
}
