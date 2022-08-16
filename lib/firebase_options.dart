// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAR0xsa-y73bKHOl5WKhar_CDk6wZgQAEY',
    appId: '1:1023245376291:web:fe6cff203cf48c6273ca96',
    messagingSenderId: '1023245376291',
    projectId: 'udeep500',
    authDomain: 'udeep500.firebaseapp.com',
    databaseURL: 'https://udeep500-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udeep500.appspot.com',
    measurementId: 'G-JYLJFM18NS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBV466KvvlADI7jLMQRhSyRsJhsIxrEfWE',
    appId: '1:1023245376291:android:fc6f26f9e101c1be73ca96',
    messagingSenderId: '1023245376291',
    projectId: 'udeep500',
    databaseURL: 'https://udeep500-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udeep500.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADYgOtO05TCLlrvdG2FezatB0vWFp3GY0',
    appId: '1:1023245376291:ios:6cd9cd4e1454e5fd73ca96',
    messagingSenderId: '1023245376291',
    projectId: 'udeep500',
    databaseURL: 'https://udeep500-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udeep500.appspot.com',
    iosClientId: '1023245376291-0md3uihfbrmpaqgs6hfm3nhvr9f7k28m.apps.googleusercontent.com',
    iosBundleId: 'com.udeep500.logi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADYgOtO05TCLlrvdG2FezatB0vWFp3GY0',
    appId: '1:1023245376291:ios:6cd9cd4e1454e5fd73ca96',
    messagingSenderId: '1023245376291',
    projectId: 'udeep500',
    databaseURL: 'https://udeep500-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udeep500.appspot.com',
    iosClientId: '1023245376291-0md3uihfbrmpaqgs6hfm3nhvr9f7k28m.apps.googleusercontent.com',
    iosBundleId: 'com.udeep500.logi',
  );
}
