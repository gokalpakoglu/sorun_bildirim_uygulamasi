import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final auth = FirebaseAuthService();

  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email,
          emailErrorMsg: validateEmail(email: event.email)));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          passwordErrorMsg: validatePassword(password: event.password)));
    });
    on<LoginSubmitted>((event, emit) async {
      try {
        await auth.loginUser(state.email, state.password);
        emit(state.copyWith(appStatus: AppStatus.loaded));
      } catch (e) {
        emit(state.copyWith(appStatus: AppStatus.error));
      }
    });
  }
}

/// The validateEmail method checks the email field.
String? validateEmail({String? email}) {
  if (email?.isEmpty ?? false) {
    return 'Email cannot be empty';
  } else if (!(email?.contains('@') ?? false)) {
    return 'Email is not valid';
  } else {
    return null;
  }
}

/// The validatePassword method checks the password field.
String? validatePassword({String? password}) {
  if (password?.isEmpty ?? false) {
    return 'Password cannot be empty';
  } else if ((password?.length ?? 0) < 6) {
    debugPrint(password?.length.toString());
    return 'Password must be at least 6 characters';
  } else {
    return null;
  }
}
