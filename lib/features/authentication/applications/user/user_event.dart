part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserEvent {
  final String nickName;
  const CreateUserEvent(this.nickName);
}

class GetListUserEvent extends UserEvent {}
