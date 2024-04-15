import 'package:flutter/material.dart';
import 'package:logo_quiz/Screen/Home_screen/home_screen.dart';
import 'package:logo_quiz/Screen/Splash_screen/splash_screen.dart';
import 'package:logo_quiz/Screen/level_screen/level_screen.dart';
import 'package:logo_quiz/Screen/logo_category_screen/logo_category_screen.dart';
import 'package:logo_quiz/Screen/one_logo_screen/one_logo_screen.dart';
import 'package:logo_quiz/Screen/spin_master_screen/spin_screen.dart';

class Router {
  static MaterialPageRoute onRouteGenrator(settings) {
    switch (settings.name) {
      case splash_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const splash_screen(),
        );
      case home_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const home_screen(),
        );
      case logo_category_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const logo_category_screen(),
        );
      case one_logo_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => one_logo_screen(
            oneData: settings.arguments['oneLogo'],
            index: settings.arguments['Index'],
            length: settings.arguments['Length'],
          ),
        );
      case levels_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => levels_screen(),
        );
      case spin_screen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => spin_screen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
