part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class UserAuthorizeEvent extends AuthorizationEvent {
  final User user;

  const UserAuthorizeEvent(this.user);
}

class LogoutEvent extends AuthorizationEvent {}
