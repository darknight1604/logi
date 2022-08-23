import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/base_services/logi_run_zoned.dart';
import 'package:logi/core/constants/logi_constant.dart';
import 'package:logi/core/factories/logi_bloc_observer_factory.dart';
import 'package:logi/core/factories/logi_run_zoned_factory.dart';
import 'package:logi/core/helpers/app_config.dart';
import 'package:logi/core/helpers/config_reader.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/services/logi_service.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/repositories/user_repository.dart';
import 'package:logi/features/home/repository/chat_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load json config
  final configData = await ConfigReader.getConfigJson();
  AppConfig(configData);
  await LogiService.initialFirebase();
  await EasyLocalization.ensureInitialized();

  // Add bloc Observer
  Bloc.observer = LogiBlocObserverFactory.getBlocObserver(
    defaultObserver: AppConfig.instance?.blocObserver ?? true,
  );

  LogiRunZoned logiRunZoned = LogiRunZonedFactory.getRunZoned();
  logiRunZoned.runZoned(
    () => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('vi'),
        ],
        path: 'assets/translations',
        // startLocale: const Locale('vi'),
        fallbackLocale: const Locale('vi'),
        child: const LogiApp(),
      ),
    ),
  );
}

class LogiApp extends StatelessWidget {
  const LogiApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<ChatRepository>(
          create: (_) => ChatRepository(),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthorizationBloc>(
              create: (_) => AuthorizationBloc(
                  RepositoryProvider.of<UserRepository>(context)),
            ),
          ],
          child: MaterialApp(
            title: LogiConstant.appName,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: LogiRoute.welcomeScreen,
            onGenerateRoute: LogiRoute.onGenerateRoute,
          ),
        );
      }),
    );
  }
}
