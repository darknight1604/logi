part of 'room_bloc.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState.initial() = _Initial;
  const factory RoomState.loading() = RoomLoading;
  const factory RoomState.listRoomState(Map<Room, List<RoomUser>> listRoomData) = ListRoomState;
  const factory RoomState.requestFailure(LogiException logiException) =
      RoomRequestFailure;
}
