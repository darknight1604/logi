import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logi/core/firebase/firebase_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseRepository.initialFirebase();
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
        onPressed: _addDataFirestore,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addDataFirestore() async {
    print('press');
    final db = FirebaseFirestore.instance;

//     // Create a new user with a first and last name
//     final fruit = <String, dynamic>{
//       "name": "Organe",
//       "active": true,
//     };

// // Add a new document with a generated ID
//     db.collection("fruits").add(fruit).then((DocumentReference doc) =>
//         print('DocumentSnapshot added with ID: ${doc.id}'));

    await db.collection("fruits").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
