import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';

const String apiKey = 'AIzaSyAR0xsa-y73bKHOl5WKhar_CDk6wZgQAEY';
const String projectId = 'udeep500';
const String authDomain = 'udeep500.firebaseapp.com';
const String databaseURL =
    'https://udeep500-default-rtdb.asia-southeast1.firebasedatabase.app';
const String storageBucket = "udeep500.appspot.com";
const measurementId = "G-JYLJFM18NS";

const FirebaseOptions web = FirebaseOptions(
  apiKey: apiKey,
  appId: '1:1023245376291:web:fe6cff203cf48c6273ca96',
  messagingSenderId: '1023245376291',
  projectId: projectId,
  authDomain: authDomain,
  databaseURL: databaseURL,
  storageBucket: storageBucket,
  measurementId: measurementId,
);

void main() {
  // Firestore.initialize(projectId);
  Firebase.initializeApp(options: web);
  // FirebaseDatabase.instance.
  runApp(const LogiApp());
}

class LogiApp extends StatelessWidget {
  const LogiApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // CollectionReference collectionReference =
    //     Firestore.instance.collection('/fruits');
    // DocumentReference documentReference =
    //     collectionReference.document('KtpZtOP3h41XJhNLXy89');
    //     documentReference.
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
