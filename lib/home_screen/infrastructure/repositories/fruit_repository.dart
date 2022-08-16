import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/helpers/storage_helper.dart';
import 'package:logi/home_screen/domain/models/fruit.dart';

class FruitRepository {
  Future<List<Fruit>> getListFruit() async {
    List<Fruit> results = [];

    StorageBehavior storageBehavior = StorageHelper.getStorageBehavior();
    List<Map<String, dynamic>> listJson =
        await storageBehavior.get(path: CollectionConstant.fruits);
    for (var doc in listJson) {
      results.add(Fruit.fromJson(doc));
    }
    return results;
  }

  Future<void> addFruit(Fruit fruit) async {
    // await db
    //     .collection("cities")
    //     .add(
    //       fruit.toJson(),
    //     )
    //     .then(
    //       (documentSnapshot) =>
    //           print("Added Data with ID: ${documentSnapshot.id}"),
    //     );
  }

  // void onListen(void Function(QuerySnapshot<Object?> event) onListen) {
  //   // final Stream<QuerySnapshot> streamController =
  //   //     db.collection("fruits").snapshots();

  //   // // streamController.listen((event) {
  //   // //   event.docs.map((e) => Fruit.fromJson(e.data() as Map<String, dynamic>));
  //   // // });
  //   // streamController.listen(onListen);
  // }
}
