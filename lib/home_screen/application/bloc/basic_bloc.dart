import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/home_screen/domain/models/fruit.dart';
import 'package:logi/home_screen/infrastructure/repositories/fruit_repository.dart';

part 'basic_event.dart';
part 'basic_state.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  final FruitRepository fruitRepository;
  BasicBloc(this.fruitRepository) : super(BasicInitial()) {
    // fruitRepository.onListen(onListen);
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
  }

  void onListen(QuerySnapshot<Object?> event) {
    if (event.docs.isEmpty) return;
    List<Fruit> newListFruit = event.docs
        .map((e) => Fruit.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    add(ReloadListFruitEvent(newListFruit));
  }
}
