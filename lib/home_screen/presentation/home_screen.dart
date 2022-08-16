import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/home_screen/application/bloc/basic_bloc.dart';
import 'package:logi/home_screen/domain/models/fruit.dart';
import 'package:logi/home_screen/infrastructure/repositories/fruit_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasicBloc(
        RepositoryProvider.of<FruitRepository>(context),
      )..add(GetListFruitEvent()),
      child: Scaffold(
        body: BlocBuilder<BasicBloc, BasicState>(
          builder: (context, state) {
            if (state is! ListFruitState) {
              return const Text('Empty data');
            }
            List<Fruit> listFruit = state.listFruit;
            return ListView.builder(
              itemCount: listFruit.length,
              itemBuilder: (_, index) {
                Fruit fruit = listFruit[index];
                return Text(fruit.name ?? 'No-name');
              },
            );
          },
        ),
      ),
    );
  }
}
