import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logi/core/domains/models/user.dart';
import 'package:logi/core/infastructures/repositories/user_repository.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc
    extends HydratedBloc<AuthorizationEvent, AuthorizationState> {
  final UserRepository userRepository;
  AuthorizationBloc(this.userRepository) : super(AuthorizationInitial()) {
    on<UserAuthorizeEvent>((event, emit) {
      emit(UserAuthorizedState(event.user));
    });
    on<LogoutEvent>(_onLogoutEvent);
  }

  @override
  AuthorizationState? fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json);
    return UserAuthorizedState(user);
  }

  @override
  Map<String, dynamic>? toJson(AuthorizationState state) {
    Map<String, dynamic> json = {};
    if (state is! UserAuthorizedState) return json;
    if (!state.isAuthorized) return json;
    if (state.user?.idIsValid == false) return json;
    return state.user?.toJson();
  }

  Future<void> _onLogoutEvent(event, emit) async {
    if (state is! UserAuthorizedState) return;
    final currentState = state as UserAuthorizedState;
    if (!currentState.isAuthorized) return;
    userRepository.deleteUser(currentState.user?.id ?? '');
    emit(const UserAuthorizedState(null));
  }
}
