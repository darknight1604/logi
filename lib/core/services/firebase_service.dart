import 'package:firebase_core/firebase_core.dart';
import 'package:logi/core/base_services/logi_service.dart';
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/firebase_options.dart';

class FirebaseService extends LogiService implements StorageBehavior {
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
  Future<List<Map<String, dynamic>>> get({required String path}) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
