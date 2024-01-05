import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      } on FirebaseAuthException catch (e) {
        // FirebaseAuthException durumunda hata yakalanabilir
        if (e.code == 'user-not-found') {
          // Kullanıcı bulunamadı hatası
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          // Yanlış şifre hatası
          print('Wrong password provided for that user.');
        }
        // Firebase tarafından gelen diğer hataların kontrolü burada yapılabilir
        print(e.toString());
        return;
      }
    });
  }
}

String? validateEmail({String? email}) {
  if (email?.isEmpty ?? false) {
    return 'Email cannot be empty';
  } else if (!(email?.contains('@') ?? false)) {
    return 'Email is not valid';
  } else {
    return null;
  }
}

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
