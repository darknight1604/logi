import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/base_services/logi_base_service.dart';
import 'package:logi/core/factories/logi_service_factory.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/repositories/user_repository.dart';
import 'package:logi/features/caro/infrastructures/repositories/caro_repository.dart';
import 'package:logi/features/home/repositories/chat_repository.dart';
import 'package:logi/features/room/applications/room/room_bloc.dart';
import 'package:logi/features/room/repositories/room_repository.dart';

class LogiService {
  static Future<void> initialFirebase() async {
    LogiBaseService logiService = LogiServiceFactory.getService();
    await logiService.initService();
  }

  static List<RepositoryProvider> initialRepoProvider() {
    return [
      RepositoryProvider<UserRepository>(
        create: (_) => UserRepository(),
      ),
      RepositoryProvider<ChatRepository>(
        create: (_) => ChatRepository(),
      ),
      RepositoryProvider<RoomRepository>(
        create: (_) => RoomRepository(),
      ),
      RepositoryProvider<CaroRepository>(
        create: (_) => CaroRepository(),
      ),
    ];
  }

  static List<BlocProvider> initialBlocProvider(
    final BuildContext buildContext,
  ) {
    return [
      BlocProvider<AuthorizationBloc>(
        create: (_) => AuthorizationBloc(
          RepositoryProvider.of<UserRepository>(buildContext),
        ),
      ),
      BlocProvider<RoomBloc>(
        create: (_) => RoomBloc(
          RepositoryProvider.of<RoomRepository>(buildContext),
        ),
      ),
    ];
  }
}
