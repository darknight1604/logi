import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/helpers/log.dart';
import 'package:logi/features/authentication/domains/models/user.dart';
import 'package:logi/features/authentication/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(
    this.userRepository,
  ) : super(UserInitialState()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<GetListUserEvent>(_onGetListUserEvent);
  }

  Future<void> _onCreateUserEvent(CreateUserEvent event, emit) async {
    try {
      emit(UserLoadingState());
      User? user = await userRepository.createUser(event.nickName);
      if (user == null) return;
      emit(CreateUserSuccessState(user));
      add(GetListUserEvent());
    } catch (e) {
      Log.error('_onCreateUserEvent', e.toString());
      emit(UserRequestFailureState());
    }
  }

  Future<void> _onGetListUserEvent(event, emit) async {
    try {
      emit(UserLoadingState());
      List<User> users = await userRepository.getListUser();
      emit(ListUserState(users));
    } catch (e) {
      emit(UserRequestFailureState());
    }
  }
}
