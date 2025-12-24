import 'package:flutter/material.dart';

class NavigatorService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState? get _state => navigatorKey.currentState;

  static Future<dynamic>? pushNamed(String routeName, {Object? arguments}) {
    return _state?.pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic>? pushReplacementNamed(String routeName, {Object? arguments}) {
    return _state?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic>? pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    return _state?.pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }

  static void pop<T extends Object?>({T? result}) {
    return _state?.pop(result);
  }

  static bool canPop() => _state?.canPop() ?? false;
}
