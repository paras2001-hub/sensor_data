import 'package:flutter/material.dart';
import 'package:sensor_data/sensor_data/presentation/pages/home_page.dart';
import 'package:sensor_data/sensor_data/presentation/pages/initial_page.dart';

import 'constants.dart';

class NavigationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) => const InitialPage());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static PageRouteBuilder fadeRouteTransition(
      Widget pageToNavigateTo, double begin, double end, Curve curve) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageToNavigateTo,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
