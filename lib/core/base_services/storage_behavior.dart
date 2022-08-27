import 'dart:async';

import 'package:logi/core/base_services/base_query.dart';

abstract class StorageBehavior {
  Future<dynamic> add({
    required String path,
    required Map<String, dynamic> jsonData,
  });
  Future<void> update();
  Future<List<Map<String, dynamic>>> get({required String path});

  Future<List<Map<String, dynamic>>> where({
    required String path,
    required String field,
    dynamic isEqualTo,
  });
  Future<bool> delete({
    required String path,
    required String id,
  });
  StreamSubscription onListenCollection({
    required String path,
    required void Function(List<Map<String, dynamic>>) onData,
  });

  Future<bool> deleteWhere({
    required String path,
    required List<BaseQuery> listQuery,
  });
}
