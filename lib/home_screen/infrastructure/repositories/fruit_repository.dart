import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logi/home_screen/domain/models/fruit.dart';

class FruitRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Fruit>> getListFruit() async {
    List<Fruit> results = [];
    await db.collection("fruits").get().then((event) {
      for (var doc in event.docs) {
        results.add(Fruit.fromJson(doc.data()));
      }
    });
    return results;
  }

  Future<void> addFruit(Fruit fruit) async {
    await db
        .collection("cities")
        .add(
          fruit.toJson(),
        )
        .then(
          (documentSnapshot) =>
              print("Added Data with ID: ${documentSnapshot.id}"),
        );
  }

  void onListen(void Function(QuerySnapshot<Object?> event) onListen) {
    final Stream<QuerySnapshot> streamController =
        db.collection("fruits").snapshots();

    // streamController.listen((event) {
    //   event.docs.map((e) => Fruit.fromJson(e.data() as Map<String, dynamic>));
    // });
    streamController.listen(onListen);
  }
}
