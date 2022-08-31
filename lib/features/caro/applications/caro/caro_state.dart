part of 'caro_bloc.dart';

@freezed
class CaroState with _$CaroState {
  const factory CaroState.initial() = _Initial;

  const factory CaroState.listPositionState({
    required List<CaroPosition> listPosition,
    required List<RoomUser> roomUsers,
    String? hostId,
  }) = ListPositionState;

  const factory CaroState.notYourTurn() = NotYourTurnState;

  const factory CaroState.bingo(String winnerNickname) = BingoState;
}
