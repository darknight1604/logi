import 'dart:async';

import 'package:logi/core/base_services/base_query.dart';
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/factories/storage_factory.dart';
import 'package:logi/core/services/queries/query_equal_to.dart';
import 'package:logi/features/home/domains/enums/game_enum.dart';
import 'package:logi/features/room/domains/models/room.dart';
import 'package:logi/features/room/domains/models/room_user.dart';

class RoomRepository {
  final String _path =
      '/${CollectionConstant.logi}/${CollectionConstant.dev}/${CollectionConstant.rooms}';
  final String _pathRoomUsers =
      '/${CollectionConstant.logi}/${CollectionConstant.dev}/${CollectionConstant.roomUsers}';

  final StorageBehavior _behavior = StorageFactory.getStorageBehavior();

  Future<List<Room>> getListRoom(GameEnum gameEnum) async {
    List<Map<String, dynamic>> jsonData = await _behavior.where(
      path: _path,
      field: "gameEnum",
      isEqualTo: gameEnum.name,
    );
    return jsonData.map((e) => Room.fromJson(e)).toList();
  }

  Future<bool> joinRoom(RoomUser roomUser) async {
    bool result = false;
    await _behavior
        .add(path: _pathRoomUsers, jsonData: roomUser.toJson())
        .then((value) {
      if (value == null) return null;
      result = true;
    });
    return result;
  }

  Future<bool> leaveRoom({
    required String userId,
    required String roomId,
  }) async {
    List<BaseQuery> listQuery = [
      QueryEqualTo(field: 'roomId', isEqualTo: roomId),
      QueryEqualTo(field: 'userId', isEqualTo: userId),
    ];
    return await _behavior.deleteWhere(
      path: _pathRoomUsers,
      listQuery: listQuery,
    );
  }

  StreamSubscription onListenRoomUser(
    void Function(List<Map<String, dynamic>>) onData,
  ) {
    return _behavior.onListenCollection(path: _pathRoomUsers, onData: onData);
  }

  Future<List<RoomUser>> getListRoomUser(String? roomId) async {
    List<Map<String, dynamic>> jsonData;
    if (roomId == null || roomId.isEmpty == true) {
      jsonData = await _behavior.get(
        path: _pathRoomUsers,
      );
    } else {
      jsonData = await _behavior.where(
        path: _pathRoomUsers,
        field: "roomId",
        isEqualTo: roomId,
      );
    }
    return jsonData.map((e) => RoomUser.fromJson(e)).toList();
  }
}
