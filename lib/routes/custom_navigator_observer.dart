import 'package:flutter/widgets.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    //TODO: Implement
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    //TODO: Implement
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    //TODO: Implement
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
