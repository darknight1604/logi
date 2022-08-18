import 'package:flutter/material.dart';
import 'package:logi/screens/fruit_screen/presentation/fruit_screen.dart';
import 'package:logi/screens/not_found/presentations/not_found_screen.dart';
import 'package:logi/screens/welcome_screen/presentations/welcome_screen.dart';

class LogiRoute {
  static const String fruits = '/fruits';

  static const String welcomeScreen = '/welcomeScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case fruits:
        return MaterialPageRoute(
          builder: (context) {
            return const FruitScreen();
          },
        );
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const WelcomeScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const NotFoundScreen();
          },
        );
    }
  }
}
