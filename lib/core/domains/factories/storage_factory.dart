import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:logi/core/domains/base_services/storage_behavior.dart';
import 'package:logi/core/domains/services/firebase_service.dart';
import 'package:logi/core/domains/services/firestore_service.dart';

class StorageFactory {
  static StorageBehavior getStorageBehavior() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return FirestoreService();
    }
    return FirebaseService();
  }
}
