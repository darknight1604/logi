part of 'game_menu_cubit.dart';

class GameMenuState extends Equatable {
  final List<Game> listGame;
  const GameMenuState({
    required this.listGame,
  });
  @override
  List<Object?> get props => [listGame];
}

class GameMenuInitialState extends GameMenuState {
  final int indexGameInit;
  const GameMenuInitialState({
    required List<Game> listGame,
    required this.indexGameInit,
  }) : super(listGame: listGame);

  GameMenuState copyWith({
    List<Game>? listGame,
    int? indexGameInit,
  }) {
    return GameMenuInitialState(
      listGame: listGame ?? this.listGame,
      indexGameInit: indexGameInit ?? this.indexGameInit,
    );
  }

  @override
  List<Object?> get props => [
        listGame,
        indexGameInit,
      ];
}
