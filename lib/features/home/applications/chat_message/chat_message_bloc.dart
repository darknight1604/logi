import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/helpers/log.dart';
import 'package:logi/features/authentication/applications/authorization/authorization_bloc.dart';
import 'package:logi/features/authentication/domains/models/user.dart';
import 'package:logi/features/home/domains/models/message.dart';
import 'package:logi/features/home/repositories/chat_repository.dart';

part 'chat_message_event.dart';
part 'chat_message_state.dart';

class ChatMessageBloc extends Bloc<ChatMessageEvent, ChatMessageState> {
  final ChatRepository chatRepository;
  final AuthorizationBloc authorizationBloc;
  late StreamSubscription streamSubscription;
  int countMessage = 0;

  ChatMessageBloc({
    required this.chatRepository,
    required this.authorizationBloc,
  }) : super(ChatMessageInitial()) {
    streamSubscription = chatRepository.onListenMessage(_onListenMessage);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<UpdateMessageListingEvent>((event, emit) async {
      emit(ChatMessageListingState(event.messages));
    });
    on<ChatMessageScrollToBottomEvent>(
      (event, emit) => emit(ChatMessageScrollToBottomState()),
    );
    on<GetCountMessageEvent>(_onGetCountMessageEvent);
    on<GetListMessageEvent>(_onGetListMessageEvent);
  }

  @override
  Future<void> close() async {
    streamSubscription.cancel();
    super.close();
  }

  void _onListenMessage(List<Map<String, dynamic>> listJsonData) {
    List<Message> messages =
        listJsonData.map((json) => Message.fromJson(json)).toList();
    messages.sort();
    if (messages.length < countMessage) return;
    add(UpdateMessageListingEvent(messages));
    add(ChatMessageScrollToBottomEvent());
  }

  Future<void> _onSendMessageEvent(event, emit) async {
    User? user = getUser();
    if (user == null) return;
    Message message = Message(
      content: event.content,
      senderId: user.id,
      senderName: user.nickname,
      sendTime: DateTime.now().millisecondsSinceEpoch,
    );
    await chatRepository.sendMessage(message);
  }

  User? getUser() {
    if (!isAuthorized) return null;
    final currentState = authorizationBloc.state;
    return (currentState as UserAuthorizedState).user;
  }

  bool get isAuthorized {
    final currentState = authorizationBloc.state;
    return currentState is UserAuthorizedState && currentState.isAuthorized;
  }

  Future _onGetCountMessageEvent(event, emit) async {
    countMessage = await chatRepository.getCountListMessage();
    add(GetListMessageEvent());
  }

  Future _onGetListMessageEvent(event, emit) async {
    try {
      List<Message> messages = await chatRepository.getListMessage();
      emit(ChatMessageListingState(messages));
      add(ChatMessageScrollToBottomEvent());
    } catch (e) {
      Log.error('_onGetListMessageEvent', e.toString());
    }
  }
}
