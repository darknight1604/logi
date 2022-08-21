import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
import 'package:logi/screens/home_screen/presentations/home_screen.dart';
import 'package:logi/screens/not_found/presentations/not_found_screen.dart';
import 'package:logi/screens/welcome_screen/presentations/welcome_screen.dart';

class LogiRoute {
  static const String welcomeScreen = '/welcomeScreen';

  static const String homeScreen = '/homeScreen';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomeScreen:
        return MaterialPageRoute(
          builder: (context) {
            AuthorizationState authorizationState =
                BlocProvider.of<AuthorizationBloc>(context).state;
            if (authorizationState is UserAuthorizedState &&
                authorizationState.isAuthorized) {
              return const HomeScreen();
            }
            return const WelcomeScreen();
          },
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
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
