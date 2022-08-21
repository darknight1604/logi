import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:logi/core/domains/base_services/logi_service.dart';
import 'package:logi/core/domains/base_services/storage_behavior.dart';
import 'package:logi/core/helpers/app_config.dart';

class FirestoreService extends LogiService implements StorageBehavior {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  FirestoreService._internal();

  @override
  Future<void> initService() async {
    String? projectId = AppConfig.instance?.projectId;
    if (projectId == null || projectId.isEmpty) return;
    Firestore.initialize(projectId);
  }

  @override
  Future<bool> delete({
    required String path,
    required String id,
  }) async {
    bool result = false;
    CollectionReference collectionReference =
        Firestore.instance.collection(path);
    collectionReference.document(id).delete().then((value) {
      result = true;
    });
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
    CollectionReference collectionReference =
        Firestore.instance.collection(path);
    await collectionReference.add(jsonData).then(
      (value) {
        result = value.map;
        result['id'] = value.id;
      },
    ).onError((error, stackTrace) {
      return result;
    });

    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> get({required String path}) async {
    CollectionReference collectionReference =
        Firestore.instance.collection(path);

    final collection = await collectionReference.get();
    List<Document> documents = collection.toList();
    return documents.map((e) {
      Map<String, dynamic> json = e.map;
      json['id'] = e.id;
      return json;
    }).toList(growable: false);
  }

  @override
  StreamSubscription onListenCollection({
    required String path,
    required void Function(List<Map<String, dynamic>>) onData,
  }) {
    CollectionReference collectionReference =
        Firestore.instance.collection(path);
    return collectionReference.stream.listen((event) {
      List<Document> documents = event.toList();
      List<Map<String, dynamic>> listJsonData = documents.map((e) {
        Map<String, dynamic> json = e.map;
        json['id'] = e.id;
        return json;
      }).toList();
      onData(listJsonData);
    });
  }
}
