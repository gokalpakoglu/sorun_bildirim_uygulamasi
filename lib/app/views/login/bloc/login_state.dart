part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.message = '',
    this.emailErrorMsg = '',
    this.passwordErrorMsg = '',
    this.email = '',
    this.password = '',
    this.appStatus = const InitialStatus(),
  });

  final String email;
  bool get isValidEmail => email.isNotEmpty && email.contains('@');
  final String password;
  bool get isValidPassword => password.length > 5;
  final AppSubmissionStatus appStatus;
  final String emailErrorMsg;
  final String passwordErrorMsg;
  final String message;

  LoginState copyWith({
    String? email,
    String? password,
    AppSubmissionStatus? appStatus,
    String? emailErrorMsg,
    String? passwordErrorMsg,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      appStatus: appStatus ?? this.appStatus,
      emailErrorMsg: email != null ? '' : this.emailErrorMsg,
      passwordErrorMsg: password != null ? '' : this.passwordErrorMsg,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, appStatus, emailErrorMsg, passwordErrorMsg, message];
}
