part of 'chat_message_bloc.dart';

abstract class ChatMessageState extends Equatable {
  const ChatMessageState();

  @override
  List<Object> get props => [];
}

class ChatMessageInitial extends ChatMessageState {}

class ChatMessageListingState extends ChatMessageState {
  final List<Message> messages;
  const ChatMessageListingState(this.messages);
  @override
  List<Object> get props => [messages];
}

class ChatMessageScrollToBottomState extends ChatMessageState {}
