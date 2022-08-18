import 'package:easy_localization/easy_localization.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/base_services/logi_run_zoned.dart';
import 'package:logi/core/constants/logi_constant.dart';
import 'package:logi/core/factories/logi_run_zoned_factory.dart';
import 'package:logi/core/logi_route.dart';
import 'package:logi/core/repositories/firebase_repository.dart';
import 'package:logi/screens/fruit_screen/infrastructure/repositories/fruit_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRepository.initialFirebase();
  await EasyLocalization.ensureInitialized();
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
        RepositoryProvider<FruitRepository>(
          create: (_) => FruitRepository(),
        ),
      ],
      child: FluentApp(
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
  }
}
