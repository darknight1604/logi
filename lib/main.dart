import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/applications/authorization/authorization_bloc.dart';
import 'package:logi/core/constants/logi_constant.dart';
import 'package:logi/core/domains/base_services/logi_run_zoned.dart';
import 'package:logi/core/domains/factories/logi_bloc_observer_factory.dart';
import 'package:logi/core/domains/factories/logi_run_zoned_factory.dart';
import 'package:logi/core/helpers/app_config.dart';
import 'package:logi/core/helpers/config_reader.dart';
import 'package:logi/core/helpers/logi_route.dart';
import 'package:logi/core/infastructures/repositories/firebase_repository.dart';
import 'package:logi/core/infastructures/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRepository.initialFirebase();
  await EasyLocalization.ensureInitialized();

  // Add bloc Observer
  Bloc.observer = LogiBlocObserverFactory.getBlocObserver();

  // Load json config
  final configData = await ConfigReader.getConfigJson();
  AppConfig(configData);

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthorizationBloc>(
            create: (_) => AuthorizationBloc(),
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
      ),
    );
  }
}
