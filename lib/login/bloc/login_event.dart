part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SubmitLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}