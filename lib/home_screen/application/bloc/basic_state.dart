part of 'basic_bloc.dart';

abstract class BasicState extends Equatable {}

class BasicInitial extends BasicState {
  @override
  List<Object?> get props => [];
}

class ListFruitState extends BasicState {
  final List<Fruit> listFruit;

  ListFruitState(this.listFruit);
  @override
  List<Object?> get props => [listFruit];
}
