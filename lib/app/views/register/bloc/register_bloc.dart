import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final auth = FirebaseAuthService();
  final Completer<GoogleMapController> mapController = Completer();
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<RegisterSurnameChanged>((event, emit) {
      emit(state.copyWith(surname: event.surname));
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
    on<RegisterSubmitted>((event, emit) {
      AppUser user = AppUser(
        email: state.email,
        name: state.name,
        surname: state.surname,
        lat: state.lat,
        lng: state.lng,
        password: state.password,
      );
      //auth.registerUser(user);
      debugPrint(user.toString());
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
