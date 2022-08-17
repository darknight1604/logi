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
    final behavior = StorageHelper.getStorageBehavior();
    await behavior.add(
        path: CollectionConstant.fruits, jsonData: fruit.toJson());
  }

  void onListen({
    required void Function(List<Map<String, dynamic>>) onData,
  }) {
    final behavior = StorageHelper.getStorageBehavior();
    behavior.onListenCollection(
      onData: onData,
      path: CollectionConstant.fruits,
    );
  }

  Future<void> deleteFruit(String id) async {
    final behavior = StorageHelper.getStorageBehavior();
    await behavior.delete(
      id: id,
      path: CollectionConstant.fruits,
    );
  }
}
