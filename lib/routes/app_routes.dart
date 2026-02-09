
import 'package:bt_management_flutter/main.dart';
import 'package:bt_management_flutter/screens/main/main_screen.dart';
import 'package:bt_management_flutter/screens/map/map.dart';
import 'package:bt_management_flutter/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = '/';

  static const String home = '/home';
  static const String login = '/login';
  static const String products = '/products';

  static const String detail = '/detail';
  static const String map = '/map';
  static const String splash = '/splash';



  static Map<String, WidgetBuilder> routes = {
    splash:(_) => const SplashScreen(),
    main: (context) => const MainScreen(),
    home: (context) =>  MyHomePage(title: 'aa',),
    login: (context) => const SizedBox(),
    products: (context) => const SizedBox(),
    map:(context) => MapLauncherDemo()
  };
}