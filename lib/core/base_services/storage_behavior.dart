abstract class StorageBehavior {
  Future<bool> add({
    required String path,
    required Map<String, dynamic> jsonData,
  });
  Future<void> update();
  Future<List<Map<String, dynamic>>> get({required String path});
  Future<void> delete();
}
