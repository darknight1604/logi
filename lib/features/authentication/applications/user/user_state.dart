part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class CreateUserSuccessState extends UserState {
  final User user;
  const CreateUserSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class UserRequestFailureState extends UserState {}

class ListUserState extends UserState {
  final List<User> users;

  const ListUserState(this.users);
  @override
  List<Object> get props => [users];
}
