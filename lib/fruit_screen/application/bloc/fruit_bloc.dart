import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/fruit_screen/domain/models/fruit.dart';
import 'package:logi/fruit_screen/infrastructure/repositories/fruit_repository.dart';

part 'fruit_event.dart';
part 'fruit_state.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  final FruitRepository fruitRepository;
  FruitBloc(this.fruitRepository) : super(BasicInitial()) {
    fruitRepository.onListen(onData: onListen);
    on<GetListFruitEvent>((event, emit) async {
      try {
        List<Fruit> results = await fruitRepository.getListFruit();
        emit(ListFruitState(results));
      } catch (e) {
        print(e.toString());
      }
    });
    on<ReloadListFruitEvent>((event, emit) async {
      emit(ListFruitState(event.listFruit));
    });
    on<DeleteFruitEvent>(_onDeleteFruitEvent);
    on<AddFruitEvent>(_onAddFruitEvent);
  }

  void onListen(List<Map<String, dynamic>> listJsonData) {
    if (listJsonData.isEmpty) return;
    List<Fruit> newListFruit =
        listJsonData.map((e) => Fruit.fromJson(e)).toList();
    add(ReloadListFruitEvent(newListFruit));
  }

  Future<void> _onDeleteFruitEvent(DeleteFruitEvent event, emit) async {
    if (event.id.isEmpty) return;
    await fruitRepository.deleteFruit(event.id);
    add(GetListFruitEvent());
  }

  Future<void> _onAddFruitEvent(AddFruitEvent event, emit) async {
    if (event.name.isEmpty) return;
    Fruit fruit = Fruit(name: event.name, active: event.active);
    await fruitRepository.addFruit(fruit);
  }
}
