import 'dart:async';

import 'package:logi/core/base_services/base_query.dart';
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/factories/storage_factory.dart';
import 'package:logi/core/services/queries/query_equal_to.dart';
import 'package:logi/features/caro/domains/models/caro_position.dart';

class CaroRepository {
  final String _path =
      '/${CollectionConstant.logi}/${CollectionConstant.dev}/${CollectionConstant.caroSteps}';

  final StorageBehavior _behavior = StorageFactory.getStorageBehavior();

  Future<bool> selectPosition(CaroPosition caroPosition) async {
    bool result = false;
    await _behavior
        .add(path: _path, jsonData: caroPosition.toJson())
        .then((value) {
      if (value == null) return null;
      result = true;
    });
    return result;
  }

  Future<bool> clearData({
    required String roomId,
  }) async {
    List<BaseQuery> listQuery = [
      QueryEqualTo(field: 'roomId', isEqualTo: roomId),
    ];
    return await _behavior.deleteWhere(
      path: _path,
      listQuery: listQuery,
    );
  }

  StreamSubscription onListenCaroSteps(
    void Function(List<Map<String, dynamic>>) onData,
  ) {
    return _behavior.onListenCollection(path: _path, onData: onData);
  }
}
