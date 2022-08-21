part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object?> get props => [];
}

class AuthorizationInitial extends AuthorizationState {}

class UserAuthorizedState extends AuthorizationState {
  final User? user;

  const UserAuthorizedState(this.user);

  bool get isAuthorized => user != null && user?.idIsValid == true;

  @override
  List<Object?> get props => [user];
}
