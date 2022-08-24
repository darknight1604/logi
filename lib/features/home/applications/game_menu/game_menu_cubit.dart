import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/home/domains/models/game.dart';

part 'game_menu_state.dart';

class GameMenuCubit extends Cubit<GameMenuState> {
  GameMenuCubit()
      : super(GameMenuInitialState(
          listGame: _GameManager.listGameAvailable(),
          indexGameInit: 0,
        ));

  void down() {
    if (state is! GameMenuInitialState) return;
    final currentState = state as GameMenuInitialState;
    int indexCurrentGame = currentState.indexGameInit;
    if (indexCurrentGame < currentState.listGame.length - 1) {
      emit(
        currentState.copyWith(
          indexGameInit: indexCurrentGame + 1,
        ),
      );
      return;
    }
  }

  void up() {
    if (state is! GameMenuInitialState) return;
    final currentState = state as GameMenuInitialState;
    int indexCurrentGame = currentState.indexGameInit;
    if (indexCurrentGame > 0) {
      emit(
        currentState.copyWith(
          indexGameInit: indexCurrentGame - 1,
        ),
      );
      return;
    }
  }
}

class _GameManager {
  static List<Game> listGameAvailable() {
    return const [
      Game(
        gameEnum: GameEnum.caro,
      ),
      Game(
        gameEnum: GameEnum.threeCard,
      )
    ];
  }
}
