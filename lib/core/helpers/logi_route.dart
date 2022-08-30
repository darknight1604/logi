import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/presentations/welcome_screen/welcome_screen.dart';
import 'package:logi/features/caro/presentations/caro_screen.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/home/presentations/home_screen.dart';
import 'package:logi/features/not_found/presentations/not_found_screen.dart';
import 'package:logi/features/room/presentations/room_listing_screen.dart';

class LogiRoute {
  static const String welcomeScreen = '/welcomeScreen';

  static const String homeScreen = '/homeScreen';

  static const String roomListingScreen = '/roomListingScreen';

  static const String caroScreen = '/caroScreen';

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
      case roomListingScreen:
        GameEnum gameEnum = settings.arguments as GameEnum;
        return MaterialPageRoute(
          builder: (context) {
            return RoomListingScreen(
              gameEnum: gameEnum,
            );
          },
        );
      case caroScreen:
        Map mapData = settings.arguments as Map;
        String roomId = mapData['roomId'];
        String userId = mapData['userId'];
        String nickname = mapData['nickname'];
        return MaterialPageRoute(
          builder: (context) {
            return CaroScreen(
              roomId: roomId,
              userId: userId,
              nickname: nickname,
            );
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
