import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _firebaseAuthService = FirebaseAuthService();

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
      emit(state.copyWith(appStatus: FormSubmitting()));
      try {
        await _firebaseAuthService.loginUser(state.email, state.password);
        emit(state.copyWith(appStatus: const SubmissionSuccess()));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            emit(state.copyWith(
              appStatus: SubmissionFailed(e.code),
              message: "Girdiğiniz eposta adresi geçersizdir.",
            ));
            break;
          case "wrong-password":
            emit(state.copyWith(
              appStatus: SubmissionFailed(e.code),
              message:
                  "Girmiş olduğunuz parola hatalı.\nTekdaha deneyebilirsiniz.",
            ));
            break;
          case "invalid-credential":
            emit(state.copyWith(
              appStatus: SubmissionFailed(e.code),
              message: "Hatalı bilgi girdiniz",
            ));
            break;
          case "user-disabled":
            emit(state.copyWith(
              appStatus: SubmissionFailed(e.code),
              message:
                  "Hesabınız engellendi.\nLütfen yönetmenizi denetleyin ve tekrar giriş yapmayı deneyin.",
            ));
            break;
          case "user-not-found":
            emit(state.copyWith(
              appStatus: SubmissionFailed(e.code),
              message:
                  "Bu kullanıcı bulunamadı.\nYeni kaydolmak ister misiniz?",
            ));
            break;
          default:
            emit(state.copyWith(
                appStatus: SubmissionFailed(e.code),
                message:
                    "Bir hata oluştu. Lütfen daha sonra tekrar deneyin veya yönetmenize başvurun."));

            throw Exception("An undefined error occurred.");
        }
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
