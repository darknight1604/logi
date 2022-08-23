import 'dart:async';

import 'package:logi/core/base_services/storage_behavior.dart';
import 'package:logi/core/constants/collection_constant.dart';
import 'package:logi/core/factories/storage_factory.dart';
import 'package:logi/features/home/domains/models/message.dart';

class ChatRepository {
  final String path =
      '/${CollectionConstant.logi}/${CollectionConstant.dev}/${CollectionConstant.globalConversations}';

  final StorageBehavior _behavior = StorageFactory.getStorageBehavior();

  Future<bool> sendMessage(Message message) async {
    bool result = false;
    _behavior
        .add(path: path, jsonData: message.toJson())
        .then((value) => result = true);
    return result;
  }

  StreamSubscription onListenMessage(
    void Function(List<Map<String, dynamic>>) onData,
  ) {
    return _behavior.onListenCollection(path: path, onData: onData);
  }

  Future<List<Message>> getListMessage() async {
    List<Map<String, dynamic>> jsonData = await _behavior.get(path: path);
    List<Message> messages = jsonData.map((e) => Message.fromJson(e)).toList();
    messages.sort();
    return messages;
  }

  Future<int> getCountListMessage() async {
    List<Message> messages = await getListMessage();
    return messages.length;
  }
}
