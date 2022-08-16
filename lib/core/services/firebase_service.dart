import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logi/core/base_services/logi_service.dart';
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/firebase_options.dart';

class FirebaseService extends LogiService implements StorageBehavior {
  static final db = FirebaseFirestore.instance;

  @override
  Future<void> initService() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
      {required String path, required Map<String, dynamic> jsonData}) {
    // TODO: implement add
    throw UnimplementedError();
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
}
