part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.emailErrorMsg,
    this.passwordErrorMsg,
    this.email = '',
    this.password = '',
    this.appStatus = AppStatus.initial,
  });

  final String email;
  bool get isValidEmail => email.isNotEmpty && email.contains('@');
  final String password;
  bool get isValidPassword => password.length > 5;
  final AppStatus appStatus;
  final String? emailErrorMsg;
  final String? passwordErrorMsg;

  LoginState copyWith({
    String? email,
    String? password,
    AppStatus? appStatus,
    String? emailErrorMsg,
    String? passwordErrorMsg,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      appStatus: appStatus ?? this.appStatus,
      emailErrorMsg: email != null ? '' : emailErrorMsg,
      passwordErrorMsg: password != null ? '' : passwordErrorMsg,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, appStatus, emailErrorMsg, passwordErrorMsg];
}

enum AppStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == AppStatus.initial;
  bool get isLoading => this == AppStatus.loading;
  bool get isLoaded => this == AppStatus.loaded;
  bool get isError => this == AppStatus.error;
}
