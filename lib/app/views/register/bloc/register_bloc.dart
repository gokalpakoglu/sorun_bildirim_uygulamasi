import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final authSerivce = FirebaseAuthService();

  final Completer<GoogleMapController> mapController = Completer();
  RegisterBloc() : super(RegisterState.initial()) {
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
      var existingUser = await authSerivce.checkExistingUser(state.email);
      try {
        if (existingUser == true) {
          emit(state.copyWith(
            errorMsg: 'Bu e-posta adresi zaten kullanılıyor.',
            appStatus: AppStatus.error,
          ));
          throw "Bu e-posta adresi ile kayıtlı bir hesap bulunmaktadır.";
        } else {
          AppUser user = AppUser(
            email: state.email,
            name: state.name,
            surname: state.surname,
            lat: state.lat,
            lng: state.lng,
            password: state.password,
          );
          debugPrint(user.toString());

          await authSerivce.registerUser(user);
          emit(state.copyWith(appStatus: AppStatus.loaded));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(appStatus: AppStatus.error, errorMsg: e.code));
      } catch (e) {
        // Genel hata durumu...
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
    debugPrint(password?.length.toString());
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
