
import 'package:bt_management_flutter/main.dart';
import 'package:bt_management_flutter/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = '/';

  static const String home = '/home';
  static const String login = '/login';
  static const String products = '/products';

  static Map<String, WidgetBuilder> routes = {
    main: (context) => const MainScreen(),
    home: (context) =>  MyHomePage(title: 'aa',),
    login: (context) => const SizedBox(),
    products: (context) => const SizedBox(),
  };
}