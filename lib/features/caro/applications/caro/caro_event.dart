part of 'caro_bloc.dart';

@freezed
class CaroEvent with _$CaroEvent {
  const factory CaroEvent.started() = _Started;

  const factory CaroEvent.initData({
    required String roomId,
    required String userId,
  }) = InitDefaultData;

  const factory CaroEvent.selectPositionData({
    required String userId,
    required String nickname,
    required CaroPosition position,
  }) = SelectPositionEvent;

  const factory CaroEvent.clearPositionData({
    required String roomId,
  }) = ClearPositionEvent;

  const factory CaroEvent.reloadData({
    required List<CaroPosition> listPosition,
    required List<RoomUser> roomUsers,
  }) = ReloadDataEvent;

  const factory CaroEvent.bingo({
    required String userId,
  }) = BingoEvent;
}
