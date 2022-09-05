import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logi/core/base_services/base_query.dart';
import 'package:logi/core/base_services/logi_base_service.dart';
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/services/queries/order_by.dart';
import 'package:logi/core/services/queries/query_equal_to.dart';
import 'package:logi/core/services/queries/query_not_equal_to.dart';
import 'package:logi/firebase_options.dart';

class FirebaseService extends LogiBaseService implements StorageBehavior {
  static final db = FirebaseFirestore.instance;

  @override
  Future<void> initService() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    db.enableNetwork();
  }

  @override
  Future<bool> delete({
    required String path,
    required String id,
  }) async {
    bool result = false;
    await db.collection(path).doc(id).delete().then((value) => result = true);
    return result;
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<dynamic> add({
    required String path,
    required Map<String, dynamic> jsonData,
  }) async {
    dynamic result;
    final documentSnapshot = await db.collection(path).add(jsonData);
    result = jsonData;
    result['id'] = documentSnapshot.id;
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> get({required String path}) async {
    List<Map<String, dynamic>> results = [];
    await db.collection(path).get().then((event) {
      for (var doc in event.docs) {
        results.add(doc.data());
      }
    });
    return results;
  }

  @override
  StreamSubscription onListenCollection({
    required String path,
    required void Function(List<Map<String, dynamic>>) onData,
  }) {
    return db.collection(path).snapshots().listen((event) {
      List<Map<String, dynamic>> listJsonData = event.docs.map((e) {
        Map<String, dynamic> jsonData = e.data();
        jsonData['id'] = e.id;
        return jsonData;
      }).toList();

      onData(listJsonData);
    });
  }

  @override
  Future<List<Map<String, dynamic>>> where({
    required String path,
    required String field,
    isEqualTo,
    List<OrderBy>? listOrderBy,
  }) async {
    Query<Map<String, dynamic>> query = db.collection(path).where(
          field,
          isEqualTo: isEqualTo,
        );
    if (listOrderBy != null && listOrderBy.isNotEmpty) {
      int i = 0;
      while (i < listOrderBy.length) {
        OrderBy orderBy = listOrderBy[i];
        query = _addOrder(
          collectionRef: query,
          orderBy: orderBy,
        );
        i++;
      }
    }
    QuerySnapshot<Map<String, dynamic>> response = await query.get();
    return response.docs.map((doc) {
      Map<String, dynamic> mapData = doc.data();
      mapData['id'] = doc.id;
      return mapData;
    }).toList();
    //  .then((event) async {
    //     for (var doc in event.docs) {
    //       Map<String, dynamic> mapData = doc.data();
    //       mapData['id'] = doc.id;
    //       results.add(mapData);
    //     }
    //   });
    // await db
    //     .collection(path)
    //     .where(field, isEqualTo: isEqualTo)
    //     .get()
    //     .then((event) {
    //   for (var doc in event.docs) {
    //     Map<String, dynamic> mapData = doc.data();
    //     mapData['id'] = doc.id;
    //     results.add(mapData);
    //   }
    // });
    // return results;
  }

  @override
  Future<bool> deleteWhere({
    required String path,
    required List<BaseQuery> listQuery,
  }) async {
    if (listQuery.isEmpty) return false;
    CollectionReference collectionRef = db.collection(path);

    int i = 0;
    Query newCollectionRef = collectionRef;
    while (i < listQuery.length) {
      BaseQuery query = listQuery[i];
      newCollectionRef = _addQuery(
        collectionRef: newCollectionRef,
        field: query.field,
        query: query,
      );
      i++;
    }
    newCollectionRef.get().then((event) async {
      for (var doc in event.docs) {
        String id = doc.id;
        await delete(path: path, id: id);
      }
    });

    return true;
  }

  Query _addQuery({
    required Query collectionRef,
    required String field,
    required BaseQuery query,
  }) {
    switch (query.runtimeType) {
      case QueryEqualTo:
        return collectionRef.where(
          field,
          isEqualTo: (query as QueryEqualTo).isEqualTo,
        );
      case QueryNotEqualTo:
        return collectionRef.where(
          field,
          isNotEqualTo: (query as QueryNotEqualTo).isNotEqualTo,
        );
      default:
    }
    return collectionRef;
  }

  Query<Map<String, dynamic>> _addOrder({
    required Query<Map<String, dynamic>> collectionRef,
    required OrderBy orderBy,
  }) {
    return collectionRef.orderBy(
      orderBy.field,
      descending: orderBy.descending,
    );
  }
}
