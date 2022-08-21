import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:logi/core/domains/base_services/logi_service.dart';
import 'package:logi/core/domains/services/firebase_service.dart';
import 'package:logi/core/domains/services/firestore_service.dart';

class LogiServiceFactory {
  static LogiService getService() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return FirestoreService();
    }
    return FirebaseService();
  }
}
