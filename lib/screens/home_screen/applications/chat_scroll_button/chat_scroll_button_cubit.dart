import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_scroll_button_state.dart';

class ChatScrollButtonCubit extends Cubit<bool> {
  ChatScrollButtonCubit() : super(false);

  void showButton() => emit(true);

  void hideButton() => emit(false);
}
