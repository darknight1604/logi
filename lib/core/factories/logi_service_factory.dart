import 'package:logi/core/base_services/logi_service.dart';

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:logi/core/services/firebase_service.dart';
import 'package:logi/core/services/firestore_service.dart';

class LogiServiceFactory {
  static LogiService getService() {
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return FirestoreService();
    }
    return FirebaseService();
  }
}
