import 'package:firedart/firedart.dart';
import 'package:logi/core/base_services/logi_service.dart';
import 'package:logi/core/base_services/storage_behavior.dart';

class FirestoreService extends LogiService implements StorageBehavior {
  static const _projectId = 'udeep500';

  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() => _instance;

  FirestoreService._internal();

  @override
  Future<void> initService() async {
    Firestore.initialize(_projectId);
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> add(
      {required String path, required Map<String, dynamic> jsonData}) async {
    bool result = false;
    CollectionReference collectionReference =
        Firestore.instance.collection(path);

    await collectionReference
        .add(jsonData)
        .then(
          (value) => result = true,
        )
        .onError((error, stackTrace) {
      print(error.toString());
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
    return documents.map((e) => e.map).toList(growable: false);
  }
}
