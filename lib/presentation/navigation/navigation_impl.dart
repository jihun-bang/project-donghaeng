import 'package:flutter/material.dart';

import 'navigation.dart';

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  get key => navigatorKey;

  @override
  void pop({Object? arguments}) {
    navigatorKey.currentState?.pop();
  }

  @override
  Future<void> pushNamed(String routeName, {Object? arguments}) async {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<void> pushNamedAndRemoveAll(String routeName,
      {Object? arguments}) async {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }
}
