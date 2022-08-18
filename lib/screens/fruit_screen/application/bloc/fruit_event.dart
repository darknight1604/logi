part of 'fruit_bloc.dart';

abstract class FruitEvent {}

class GetListFruitEvent extends FruitEvent {}

class ReloadListFruitEvent extends FruitEvent {
  final List<Fruit> listFruit;
  ReloadListFruitEvent(this.listFruit);
}

class DeleteFruitEvent extends FruitEvent {
  final String id;
  DeleteFruitEvent(this.id);
}

class AddFruitEvent extends FruitEvent {
  final String name;
  final bool active;
  AddFruitEvent({required this.name, required this.active});
}
