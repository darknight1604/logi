import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:logi/firebase_options.dart';

class FirebaseRepository {
  static Future<void> initialFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
