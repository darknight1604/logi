part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends WelcomeEvent {
  final String nickName;
  const CreateUserEvent(this.nickName);
}

class GetListUserEvent extends WelcomeEvent {}
