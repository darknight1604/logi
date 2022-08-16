import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/firebase/firebase_repository.dart';
import 'package:logi/home_screen/infrastructure/repositories/fruit_repository.dart';
import 'package:logi/home_screen/presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRepository.initialFirebase();
  runApp(const LogiApp());
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
      child: MaterialApp(
        title: 'Logi app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
