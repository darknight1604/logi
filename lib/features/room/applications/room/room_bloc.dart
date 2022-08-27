import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logi/core/exceptions/logi_exception.dart';
import 'package:logi/features/authentication/domains/models/user.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/room/domains/models/room.dart';
import 'package:logi/features/room/domains/models/room_user.dart';
import 'package:logi/features/room/repositories/room_repository.dart';

part 'room_event.dart';
part 'room_state.dart';
part 'room_bloc.freezed.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  late StreamSubscription streamSubscription;

  RoomBloc(
    this.roomRepository,
  ) : super(const _Initial()) {
    streamSubscription = roomRepository.onListenRoomUser(_onListenRoomUser);
    on<GetListRoomEvent>((event, emit) async {
      emit(const RoomLoading());
      try {
        List<Room> rooms = await roomRepository.getListRoom(event.gameEnum);
        Map<Room, List<RoomUser>> listRoomData = {};
        for (var room in rooms) {
          listRoomData.putIfAbsent(room, () => []);
        }
        emit(ListRoomState(listRoomData));
        List<RoomUser> roomUsers = await roomRepository.getListRoomUser(null);
        add(ListenUserJoinRoomEvent(roomUsers: roomUsers));
      } catch (e) {
        emit(
          RoomRequestFailure(LogiException(e)),
        );
      }
    });
    on<ListenUserJoinRoomEvent>(_onListenUserJoinRoomEvent);
    on<JoinRoomEvent>(_onJoinRoomEvent);
    on<LeaveRoomEvent>(_onLeaveRoomEvent);
  }

  Future _onListenUserJoinRoomEvent(ListenUserJoinRoomEvent event, emit) async {
    if (state is! ListRoomState) return;
    final currentState = state as ListRoomState;
    List<RoomUser> listRoomUser = event.roomUsers;
    Map<Room, List<RoomUser>> listRoomData =
        currentState.listRoomData.map((key, value) => MapEntry(key, []));
    for (var i = 0; i < listRoomUser.length; i++) {
      RoomUser roomUser = listRoomUser[i];
      List<Room> keyTemps = listRoomData.keys
          .where((element) => element.id == roomUser.roomId)
          .toList();
      if (keyTemps.isEmpty) continue;
      Room room = keyTemps.first;

      List<RoomUser> roomUsers = await roomRepository.getListRoomUser(
        room.id ?? '',
      );
      listRoomData[room] = roomUsers;
    }
    emit(ListRoomState(listRoomData));
  }

  void _onListenRoomUser(List<Map<String, dynamic>> listJsonData) async {
    List<RoomUser> roomUsers =
        listJsonData.map((json) => RoomUser.fromJson(json)).toList();
    await Future.delayed(const Duration(seconds: 1));
    add(ListenUserJoinRoomEvent(roomUsers: roomUsers));
  }

  Future _onJoinRoomEvent(JoinRoomEvent event, emit) async {
    RoomUser roomUser = RoomUser(
      nickName: event.user.nickname,
      roomId: event.room.id,
      userId: event.user.id,
    );
    await roomRepository.joinRoom(roomUser);
  }

  Future _onLeaveRoomEvent(
    LeaveRoomEvent event,
    emit,
  ) async {
    await roomRepository.leaveRoom(
      userId: event.user.id ?? '',
      roomId: event.room.id ?? '',
    );
  }

  @override
  Future close() async {
    streamSubscription.cancel();
    super.close();
  }
}
