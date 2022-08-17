import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/fruit_screen/application/bloc/fruit_bloc.dart';
import 'package:logi/fruit_screen/domain/models/fruit.dart';
import 'package:logi/fruit_screen/infrastructure/repositories/fruit_repository.dart';

class FruitScreen extends StatefulWidget {
  const FruitScreen({Key? key}) : super(key: key);

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FruitBloc>(
      create: (context) => FruitBloc(
        RepositoryProvider.of<FruitRepository>(context),
      )..add(GetListFruitEvent()),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const _ListFruitWidget(),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: controller,
                      ),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.text.isEmpty) return;
                          BlocProvider.of<FruitBloc>(context).add(
                            AddFruitEvent(
                              name: controller.text,
                              active: true,
                            ),
                          );
                          controller.clear();
                        },
                        child: const Icon(
                          Icons.send_outlined,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ListFruitWidget extends StatelessWidget {
  const _ListFruitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FruitBloc, FruitState>(
      builder: (context, state) {
        if (state is! ListFruitState) {
          return const Text('Empty data');
        }
        List<Fruit> listFruit = state.listFruit;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: listFruit.length,
          itemBuilder: (_, index) {
            Fruit fruit = listFruit[index];
            bool active = fruit.active ?? false;
            return Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(fruit.name ?? 'No-name'),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                active
                    ? const Icon(
                        Icons.check_box_outlined,
                      )
                    : const Icon(
                        Icons.check_box_outline_blank_outlined,
                      ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<FruitBloc>(context).add(
                      DeleteFruitEvent(fruit.id ?? ''),
                    );
                  },
                  child: const Icon(
                    Icons.remove_circle_outline_outlined,
                    color: Colors.red,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
