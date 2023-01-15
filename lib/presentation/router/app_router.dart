import 'package:bloc_tiberiu/presentation/screens/home_screen.dart';
import 'package:bloc_tiberiu/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/second':
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(
            title: 'SecondScreen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(
            title: 'ThirdScreen',
            color: Colors.greenAccent,
          ),
        );
      case '/settings-page':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      case '/':
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'HomeScreen',
            color: Colors.blueAccent,
          ),
        );
    }
  }
}
