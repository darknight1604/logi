import 'dart:core';

import 'package:equatable/equatable.dart';

class Message extends Equatable implements Comparable<Message> {
  final String? senderId;
  final String? senderName;
  final String? content;
  final int? sendTime;
  final String? id;

  const Message({
    this.senderId,
    this.senderName,
    this.content,
    this.sendTime,
    this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json['senderId'],
        senderName: json['senderName'],
        content: json['content'],
        sendTime: json['sendTime'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['senderId'] = senderId;
    json['content'] = content;
    json['senderName'] = senderName;
    json['sendTime'] = sendTime;
    json.removeWhere((key, value) => value == null);
    return json;
  }

  @override
  List<Object?> get props => [id, senderId, sendTime];

  @override
  int compareTo(Message other) {
    if (this == other) return 0;
    return (sendTime ?? 0) > (other.sendTime ?? 0) ? 1 : -1;
  }
}
