part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginEmailChanged extends LoginEvent {
  LoginEmailChanged({this.email});
  final String? email;
  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged({this.password});
  final String? password;
  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted();

  @override
  List<Object?> get props => [];
}
