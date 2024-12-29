import 'package:flutter/cupertino.dart';
import 'package:routing_app/routes/route_mapper.dart';

class RouteManagement {
  static RouteManagement? _instance;

  static RouteManagement get instance => _instance ?? RouteManagement._();

  RouteManagement._();

  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
        settings: settings, builder: (context) => RouteMapper.getRoute(settings.name ?? '', settings.arguments as Map<String, dynamic>? ?? {}));
  }

  Future<dynamic> pushNamed(String routeName, {Map<String, dynamic>? args}) async {
    return navigationKey.currentState?.pushNamed(routeName, arguments: args);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Map<String, dynamic>? args}) async {
    return navigationKey.currentState?.pushReplacementNamed(routeName, arguments: args);
  }

  Future<dynamic> popAndPushNamed(String routeName, {Map<String, dynamic>? args}) async {
    return navigationKey.currentState?.popAndPushNamed(routeName, arguments: args);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, String removeRouteName, {Map<String, dynamic>? args}) async {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(routeName, withName(removeRouteName), arguments: args);
  }

  static RoutePredicate withName(String name) {
    List<String> names = [name];

    return (Route<dynamic> route) {
      return route.willHandlePopInternally && route is ModalRoute && names.contains(route.settings.name);
    };
  }
}
