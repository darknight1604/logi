part of 'welcome_bloc.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();

  @override
  List<Object> get props => [];
}

class WelcomeInitial extends WelcomeState {}

class WelcomeLoading extends WelcomeState {}

class WelcomeCreateUserSuccess extends WelcomeState {
  final User user;
  const WelcomeCreateUserSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class WelcomeRequestFailure extends WelcomeState {}

class WelcomeListUserState extends WelcomeState {
  final List<User> users;

  const WelcomeListUserState(this.users);
  @override
  List<Object> get props => [users];
}
