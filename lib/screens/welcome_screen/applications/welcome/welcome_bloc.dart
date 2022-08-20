import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logi/core/domains/models/user.dart';
import 'package:logi/core/infastructures/repositories/user_repository.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final UserRepository userRepository;
  WelcomeBloc(
    this.userRepository,
  ) : super(WelcomeInitial()) {
    on<CreateUserEvent>(_onCreateUserEvent);
    on<GetListUserEvent>(_onGetListUserEvent);
  }

  Future<void> _onCreateUserEvent(CreateUserEvent event, emit) async {
    try {
      emit(WelcomeLoading());
      User? user = await userRepository.createUser(event.nickName);
      if (user == null) return;
      emit(WelcomeCreateUserSuccess(user));
      add(GetListUserEvent());
    } catch (e) {
      emit(WelcomeRequestFailure());
    }
  }

  Future<void> _onGetListUserEvent(event, emit) async {
    try {
      emit(WelcomeLoading());
      List<User> users = await userRepository.getListUser();
      emit(WelcomeListUserState(users));
    } catch (e) {
      emit(WelcomeRequestFailure());
    }
  }
}
