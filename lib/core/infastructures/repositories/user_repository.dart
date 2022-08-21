import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/domains/base_services/storage_behavior.dart';
import 'package:logi/core/domains/factories/storage_factory.dart';
import 'package:logi/core/domains/models/user.dart';

class UserRepository {
  final String path =
      '/${CollectionConstant.logi}/${CollectionConstant.dev}/${CollectionConstant.users}';
  final StorageBehavior storageBehavior = StorageFactory.getStorageBehavior();

  Future<User?> createUser(String nickname) async {
    User? user;
    await storageBehavior
        .add(path: path, jsonData: User(nickname: nickname).toJson())
        .then((value) {
      user = User.fromJson(value);
    });
    return user;
  }

  Future<List<User>> getListUser() async {
    List<Map<String, dynamic>> listJsonData =
        await storageBehavior.get(path: path);
    return listJsonData.map(
      (e) {
        return User.fromJson(e);
      },
    ).toList(
      growable: false,
    );
  }

  Future<bool> deleteUser(String userId) async {
    return await storageBehavior.delete(path: path, id: userId);
  }
}
