import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logi/features/caro/domains/models/caro_position.dart';
import 'package:logi/features/caro/infrastructures/repositories/caro_repository.dart';
import 'package:logi/features/room/domains/models/room_user.dart';
import 'package:logi/features/room/repositories/room_repository.dart';

part 'caro_event.dart';
part 'caro_state.dart';
part 'caro_bloc.freezed.dart';

class CaroBloc extends Bloc<CaroEvent, CaroState> {
  static int maxColumn = 20;
  static int maxRow = 20;

  static int conditionWinner = 5;

  final CaroRepository caroRepository;

  late StreamSubscription streamCaroRepo;

  final RoomRepository roomRepository;

  late StreamSubscription streamRoomRepo;

  late String userId;

  late String opponentId = '';

  late String roomId;

  late bool isHost = false;

  late List<RoomUser> roomUsers = [];

  final int maxSize = 2;

  CaroBloc(
    this.caroRepository,
    this.roomRepository,
  ) : super(const _Initial()) {
    streamCaroRepo = caroRepository.onListenCaroSteps(_onListenCaroPosition);
    streamRoomRepo = roomRepository.onListenRoomUser(_onListenRoomUsers);
    on<InitDefaultData>(_onInitDefaultData);
    on<SelectPositionEvent>(_onSelectPositionEvent);
    on<ClearPositionEvent>(_onClearPositionEvent);
    on<ReloadDataEvent>(_onReloadDataEvent);
    on<BingoEvent>((event, emit) {
      String winnerId = event.userId;
      List<RoomUser> listTemp = roomUsers
          .where(
            (element) => element.userId == winnerId,
          )
          .toList();
      if (listTemp.isEmpty) return;
      emit(BingoState(listTemp.first.nickName ?? ''));
    });
  }

  Future _onInitDefaultData(event, emit) async {
    List<CaroPosition> listPosition = [];
    userId = event.userId;
    roomId = event.roomId;
    for (var row = 0; row < maxRow; row++) {
      for (var column = 0; column < maxColumn; column++) {
        listPosition.add(
          CaroPosition(
            column: column,
            row: row,
            roomId: event.roomId,
          ),
        );
      }
    }
    await Future.delayed(const Duration(seconds: 1));
    roomUsers = await roomRepository.getListRoomUser(roomId);
    isHost = userId == roomUsers.first.userId;
    emit(
      ListPositionState(
        listPosition: listPosition,
        roomUsers: roomUsers,
        hostId: isHost ? userId : null,
      ),
    );
  }

  Future _onSelectPositionEvent(SelectPositionEvent event, emit) async {
    if (state is! ListPositionState) return;
    final currentState = state as ListPositionState;
    CaroPosition position = event.position;
    List<CaroPosition> listPosition = [...currentState.listPosition];

    bool allow = allowKeepGoing(
      listPosition,
    );
    if (!allow) {
      emit(const NotYourTurnState());
      return;
    }

    int index = listPosition.indexOf(position);

    CaroPosition newPosition = event.position.copyWith(
      userId: event.userId,
      nickname: event.nickname,
    );
    listPosition.removeAt(index);
    listPosition.insert(index, newPosition);
    String? winnerId = await findWinner(listPosition);
    if (winnerId != null && winnerId.isNotEmpty == true) {
      add(BingoEvent(userId: winnerId));
    }
    emit(
      ListPositionState(
        listPosition: listPosition,
        roomUsers: roomUsers,
        hostId: isHost ? userId : null,
      ),
    );
    await caroRepository.selectPosition(
      position.copyWith(
        userId: event.userId,
      ),
    );
  }

  Future _onClearPositionEvent(ClearPositionEvent event, emit) async {
    await caroRepository.clearData(
      roomId: event.roomId,
    );
  }

  void _onListenCaroPosition(List<Map<String, dynamic>> listJsonData) async {
    if (state is! ListPositionState) return;
    final currentState = (state as ListPositionState);
    List<CaroPosition> currentData = [...currentState.listPosition];
    if (currentData.isEmpty) return;
    List<CaroPosition> newData =
        listJsonData.map((e) => CaroPosition.fromJson(e)).toList();

    for (var newPosition in newData) {
      if (newPosition.roomId != roomId) continue;
      List<CaroPosition> listTemps = currentData
          .where(
            (oldPosition) =>
                oldPosition.roomId == newPosition.roomId &&
                oldPosition.row == newPosition.row &&
                oldPosition.column == newPosition.column,
          )
          .toList();
      if (listTemps.isEmpty) continue;
      CaroPosition oldPosition = listTemps.first;
      int index = currentData.indexOf(oldPosition);
      currentData.removeAt(index);
      currentData.insert(index, newPosition);
    }

    String? winnerId = await findWinner(currentData);
    if (winnerId != null && winnerId.isNotEmpty == true) {
      add(BingoEvent(userId: winnerId));
    }

    add(
      ReloadDataEvent(
        listPosition: currentData,
        roomUsers: currentState.roomUsers,
      ),
    );
  }

  Future _onReloadDataEvent(ReloadDataEvent event, emit) async {
    emit(
      ListPositionState(
        listPosition: event.listPosition,
        roomUsers: roomUsers,
        hostId: isHost ? userId : null,
      ),
    );
  }

  Future<String?> findWinner(List<CaroPosition> listPosition) async {
    if (listPosition.isEmpty) return null;
    List<CaroPosition> selfListPosition = listPosition
        .where((element) => element.isSelected && element.userId == userId)
        .toList();
    if (findWinnerByColumn(selfListPosition, userId)) {
      return userId;
    }
    if (findWinnerByRow(selfListPosition, userId)) {
      return userId;
    }
    if (findWinnerByBackSlash(selfListPosition, userId)) {
      return userId;
    }
    if (findWinnerBySlash(selfListPosition, userId)) {
      return userId;
    }

    if (opponentId.isEmpty) return null;
    List<CaroPosition> opponentListPosition = listPosition
        .where((element) => element.isSelected && element.userId == opponentId)
        .toList();
    if (findWinnerByColumn(opponentListPosition, opponentId)) {
      return opponentId;
    }
    if (findWinnerByRow(opponentListPosition, opponentId)) {
      return opponentId;
    }
    if (findWinnerByBackSlash(opponentListPosition, opponentId)) {
      return opponentId;
    }
    if (findWinnerBySlash(opponentListPosition, opponentId)) {
      return opponentId;
    }
    return null;
  }

  bool findWinnerByColumn(
    List<CaroPosition> selfListPosition,
    String inputUserId,
  ) {
    if (selfListPosition.isEmpty) return false;

    bool bingo = false;

    List<int?> listColumn =
        selfListPosition.map((e) => e.column).toSet().toList();
    for (var column in listColumn) {
      if (column == null) continue;
      if (bingo) break;
      List<CaroPosition> listPositionByColumn = selfListPosition
          .where(
            (element) => element.isSelected && element.column == column,
          )
          .toList();
      bingo = validatePerCondition(listPositionByColumn, inputUserId);
      if (bingo) break;
    }

    return bingo;
  }

  bool findWinnerByRow(
    List<CaroPosition> selfListPosition,
    String inputUserId,
  ) {
    if (selfListPosition.isEmpty) return false;

    bool bingo = false;

    List<int?> listRow = selfListPosition.map((e) => e.row).toSet().toList();
    for (var row in listRow) {
      if (row == null) continue;
      if (bingo) break;
      List<CaroPosition> listPositionByRow = selfListPosition
          .where(
            (element) => element.isSelected && element.row == row,
          )
          .toList();
      bingo = validatePerCondition(listPositionByRow, inputUserId);
      if (bingo) break;
    }

    return bingo;
  }

  bool findWinnerByBackSlash(
    List<CaroPosition> selfListPosition,
    String inputUserId,
  ) {
    if (selfListPosition.isEmpty) return false;

    bool bingo = false;

    for (var column = 0; column < maxColumn - 4; column++) {
      List<CaroPosition> listPositionBySlash = selfListPosition
          .where(
            (element) =>
                element.isSelected &&
                (element.column ?? 0) - (element.row ?? 0) == column,
          )
          .toList();
      bingo = validatePerCondition(listPositionBySlash, inputUserId);
      if (bingo) break;
    }
    if (bingo) return bingo;

    for (var row = 1; row < maxRow - 4; row++) {
      List<CaroPosition> listPositionBySlash = selfListPosition
          .where(
            (element) =>
                element.isSelected &&
                (element.row ?? 0) - (element.column ?? 0) == row,
          )
          .toList();
      bingo = validatePerCondition(listPositionBySlash, inputUserId);
      if (bingo) break;
    }

    return bingo;
  }

  bool findWinnerBySlash(
    List<CaroPosition> selfListPosition,
    String inputUserId,
  ) {
    if (selfListPosition.isEmpty) return false;

    bool bingo = false;

    for (var column = 4; column < maxColumn; column++) {
      List<CaroPosition> listPositionBySlash = selfListPosition
          .where(
            (element) =>
                element.isSelected &&
                (element.column ?? 0) + (element.row ?? 0) == column,
          )
          .toList();
      bingo = validatePerCondition(listPositionBySlash, inputUserId);
      if (bingo) break;
    }
    if (bingo) return bingo;

    for (var row = 1; row < maxRow - 4; row++) {
      List<CaroPosition> listPositionBySlash = selfListPosition
          .where(
            (element) =>
                element.isSelected &&
                (element.row ?? 0) + (element.column ?? 0) ==
                    maxColumn - 1 + row,
          )
          .toList();
      bingo = validatePerCondition(listPositionBySlash, inputUserId);
      if (bingo) break;
    }

    return bingo;
  }

  bool validatePerCondition(List<CaroPosition> listData, String inputUserId) {
    bool bingo = false;
    int maxLengthByRow = listData.length;
    if (maxLengthByRow < conditionWinner) return bingo;
    int start = 0;
    int end = conditionWinner;
    while (end <= maxLengthByRow) {
      List<CaroPosition> setData = listData.getRange(start, end).toList();
      bingo = setData.every((element) => element.userId == inputUserId);
      if (bingo) {
        break;
      }
      start++;
      end++;
    }
    return bingo;
  }

  bool allowKeepGoing(List<CaroPosition> listPosition) {
    int countSeft = listPosition
        .where((element) => element.isSelected && element.userId == userId)
        .length;

    int countOpponent = listPosition
        .where((element) => element.isSelected && element.userId != userId)
        .length;
    if (countSeft == 0 && countOpponent == 0 && isHost) return true;
    if (isHost) {
      return countSeft == countOpponent;
    }
    return countSeft == countOpponent - 1;
  }

  void _onListenRoomUsers(List<Map<String, dynamic>> listJsonData) async {
    List<RoomUser> listRoomUser = listJsonData
        .map((e) => RoomUser.fromJson(e))
        .where((element) => element.roomId == roomId)
        .toList();
    if (listRoomUser.isEmpty) return;
    if (roomUsers.length >= maxSize) return;
    roomUsers = [];
    for (var roomUser in listRoomUser) {
      if (roomUsers.contains(roomUser)) continue;
      roomUsers.add(roomUser);
      roomUsers.sort((a, b) => (a.joinDate ?? 0) > (b.joinDate ?? 0) ? 1 : -1);
    }
    if (state is! ListPositionState) return;
    final currentState = state as ListPositionState;
    add(
      ReloadDataEvent(
        listPosition: currentState.listPosition,
        roomUsers: roomUsers,
      ),
    );
  }

  RoomUser? getHost() {
    if (roomUsers.isEmpty) return null;
    if (roomUsers.length > maxSize) return null;
    return roomUsers.first;
  }

  RoomUser? getOpponent() {
    if (roomUsers.isEmpty) return null;
    if (roomUsers.length > maxSize || roomUsers.length == 1) return null;
    return roomUsers[1];
  }

  @override
  Future close() async {
    streamCaroRepo.cancel();
    streamRoomRepo.cancel();
    super.close();
  }
}
