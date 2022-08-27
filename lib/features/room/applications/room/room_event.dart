part of 'room_bloc.dart';

@freezed
class RoomEvent with _$RoomEvent {
  const factory RoomEvent.started() = _Started;

  const factory RoomEvent.getListRoomEvent(
    GameEnum gameEnum,
  ) = GetListRoomEvent;

  const factory RoomEvent.joinRoomEvent({
    required Room room,
    required User user,
  }) = JoinRoomEvent;

  const factory RoomEvent.updateRoom({
    required Room room,
    required User user,
  }) = UpdateRoomEvent;

  const factory RoomEvent.listenUserJoinRoom({
    required List<RoomUser> roomUsers,
  }) = ListenUserJoinRoomEvent;

  const factory RoomEvent.leaveRoom({
    required User user,
    required Room room,
  }) = LeaveRoomEvent;
}
