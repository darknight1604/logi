import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/services/firebase_service.dart';
import 'package:logi/core/services/firestore_service.dart';

class StorageHelper {
  static StorageBehavior getStorageBehavior() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return FirestoreService();
    }
    return FirebaseService();
  }
}
