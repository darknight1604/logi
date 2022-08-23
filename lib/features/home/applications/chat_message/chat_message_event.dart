part of 'chat_message_bloc.dart';

abstract class ChatMessageEvent extends Equatable {
  const ChatMessageEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatMessageEvent {
  final String content;
  const SendMessageEvent(this.content);
}

class UpdateMessageListingEvent extends ChatMessageEvent {
  final List<Message> messages;

  const UpdateMessageListingEvent(this.messages);
}

class ChatMessageScrollToBottomEvent extends ChatMessageEvent {}

class GetCountMessageEvent extends ChatMessageEvent {}

class GetListMessageEvent extends ChatMessageEvent {}
