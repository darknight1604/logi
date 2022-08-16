part of 'basic_bloc.dart';

abstract class BasicEvent {}

class GetListFruitEvent extends BasicEvent {}

class ReloadListFruitEvent extends BasicEvent {
  final List<Fruit> listFruit;
  ReloadListFruitEvent(this.listFruit);
}
