import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final authSerivce = FirebaseAuthService();

  final Completer<GoogleMapController> mapController = Completer();
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(
          email: event.email,
          emailErrorMsg: validateEmail(email: event.email)));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(
          password: event.password,
          passwordErrorMsg: validatePassword(password: event.password)));
    });
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(
          name: event.name, nameErrorMsg: validateName(name: event.name)));
    });
    on<RegisterSurnameChanged>((event, emit) {
      emit(state.copyWith(
          surname: event.surname,
          surnameErrorMsg: validateSurname(surname: event.surname)));
    });
    on<RegisterLatLngChanged>((event, emit) async {
      Position position = await getCurrentLocation();
      var selectedMarker = Marker(
          markerId: const MarkerId("deneme"),
          position: LatLng(position.latitude, position.longitude));
      GoogleMapController controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 14)));

      emit(state.copyWith(
          lat: position.latitude,
          lng: position.longitude,
          marker: {selectedMarker}));
      debugPrint(selectedMarker.toString());
    });
    on<RegisterSubmitted>((event, emit) async {
      emit(state.copyWith(appStatus: FormSubmitting()));
      try {
        AppUser user = AppUser(
          email: state.email,
          name: state.name,
          surname: state.surname,
          lat: state.lat,
          lng: state.lng,
          password: state.password,
        );

        await authSerivce.registerUser(user);
        emit(state.copyWith(
          appStatus: const SubmissionSuccess(),
        ));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "invalid-email":
            emit(
              state.copyWith(
                  appStatus: SubmissionFailed(e.code),
                  message:
                      'Girilen eposta adresi geçersizdir. Lütfen doğru bir eposta adresi girin.'),
            );
            break;
          case "weak-password":
            emit(
              state.copyWith(
                  appStatus: SubmissionFailed(e.code),
                  message: 'Parolanız en az 6 karakter olmalıdır.'),
            );
            break;
          case "email-already-in-use":
            emit(
              state.copyWith(
                  appStatus: SubmissionFailed(e.code),
                  message:
                      'Bu eposta adresi zaten kullanımda. Lütfen farklı bir eposta adresi kullanarak tekrar deneyin.'),
            );
            break;
          case "operation-not-allowed":
            emit(state.copyWith(
                appStatus: SubmissionFailed(e.code),
                message:
                    'Bu işlem sunucuda devre dışı bırakıldı.\nLütfen daha sonra tekrar deneyiniz.'));
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

    on<RegisterMapCreated>((event, emit) {
      if (!mapController.isCompleted) {
        mapController.complete(event.controller);
      }
    });
    on<RegisterAnimateCamera>((event, emit) async {});
  }
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services are disabled.");
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error("Location permission are permanently denied");
  }
  Position position = await Geolocator.getCurrentPosition();
  return position;
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
    return 'Password must be at least 6 characters';
  } else {
    return null;
  }
}

String? validateName({String? name}) {
  if (name?.isEmpty ?? false) {
    return 'Name cannot be empty';
  } else {
    return null;
  }
}

String? validateSurname({String? surname}) {
  if (surname?.isEmpty ?? false) {
    return 'Surname cannot be empty';
  } else {
    return null;
  }
}
