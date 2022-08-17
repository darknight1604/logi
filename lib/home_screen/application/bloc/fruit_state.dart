part of 'fruit_bloc.dart';

abstract class FruitState extends Equatable {}

class BasicInitial extends FruitState {
  @override
  List<Object?> get props => [];
}

class ListFruitState extends FruitState {
  final List<Fruit> listFruit;

  ListFruitState(this.listFruit);
  @override
  List<Object?> get props => [listFruit];
}
