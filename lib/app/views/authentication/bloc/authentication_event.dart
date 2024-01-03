part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class RegisterUser extends AuthenticationEvent {
  final String email;
  final String password;
  const RegisterUser(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class LoginUser extends AuthenticationEvent {
  final String email;
  final String password;
  const LoginUser({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LogOut extends AuthenticationEvent {}
