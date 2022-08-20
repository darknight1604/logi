import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/domains/base_services/logi_service.dart';
import 'package:logi/core/domains/base_services/storage_behavior.dart';
import 'package:logi/firebase_options.dart';

class FirebaseService extends LogiService implements StorageBehavior {
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
  Future<bool> add({
    required String path,
    required Map<String, dynamic> jsonData,
  }) async {
    bool result = false;
    await db.collection(path).add(jsonData).then((value) {
      result = true;
    });
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> get({required String path}) async {
    List<Map<String, dynamic>> results = [];
    await db.collection(CollectionConstant.fruits).get().then((event) {
      for (var doc in event.docs) {
        results.add(doc.data());
      }
    });
    return results;
  }

  @override
  void onListenCollection({
    required String path,
    required void Function(List<Map<String, dynamic>>) onData,
  }) {
    db.collection(path).snapshots().listen((event) {
      List<Map<String, dynamic>> listJsonData = event.docs.map((e) {
        Map<String, dynamic> jsonData = e.data();
        jsonData['id'] = e.id;
        return jsonData;
      }).toList();

      onData(listJsonData);
    });
  }
}
