abstract class StorageBehavior {
  Future<dynamic> add({
    required String path,
    required Map<String, dynamic> jsonData,
  });
  Future<void> update();
  Future<List<Map<String, dynamic>>> get({required String path});
  Future<bool> delete({
    required String path,
    required String id,
  });
  void onListenCollection({
    required String path,
    required void Function(List<Map<String, dynamic>>) onData,
  });
}
