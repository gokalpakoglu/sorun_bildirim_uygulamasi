// part of 'authentication_bloc.dart';

// @immutable
// sealed class AuthenticationEvent {
//   const AuthenticationEvent();

//   List<Object> get props => [];
// }

// class RegisterUser extends AuthenticationEvent {
//   final String email;
//   final String password;
//   final String name;
//   final String surname;

//   const RegisterUser(this.email, this.password, this.name, this.surname);
//   @override
//   List<Object> get props => [email, password, name, surname];
// }

// class Location extends AuthenticationEvent {
//   final double latitude;
//   final double longitude;
//   const Location(this.latitude, this.longitude);
//   @override
//   List<Object> get props => [latitude, longitude];
// }

// class LoginUser extends AuthenticationEvent {
//   final String email;
//   final String password;
//   const LoginUser({required this.email, required this.password});
//   @override
//   List<Object> get props => [email, password];
// }

// class LogOut extends AuthenticationEvent {}
