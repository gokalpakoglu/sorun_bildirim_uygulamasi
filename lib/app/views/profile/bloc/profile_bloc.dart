import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final auth = FirebaseAuthService();
  final Completer<GoogleMapController> mapController = Completer();
  ProfileBloc() : super(const ProfileState()) {
    on<ProfileNameChanged>((event, emit) {
      emit(state.copyWith(
          name: event.name, nameErrorMsg: validateName(name: event.name)));
    });
    on<ProfileSurnameChanged>((event, emit) {
      emit(state.copyWith(
          surname: event.surname,
          surnameErrorMsg: validateSurname(surname: event.surname)));
    });
    on<ProfileLatLngChanged>((event, emit) async {
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
    on<ProfileMapCreated>((event, emit) {
      if (!mapController.isCompleted) {
        mapController.complete(event.controller);
      }
    });
    on<ProfileAnimateCamera>((event, emit) async {});

    on<ProfileSubmitted>((event, emit) async {
      try {
        // Güncellenecek verileri içeren AppUser nesnesi oluştur
        AppUser user = AppUser(
          name: state.name,
          surname: state.surname,
          lat: state.lat,
          lng: state.lng,
        );

        // Firestore üzerindeki kullanıcı bilgilerini güncelle
        auth.updateUser(user);
        debugPrint(user.toString());

        // State'i güncelle, sadece name ve surname alanları
      } catch (e) {
        // Hata durumunda yapılacak işlemler
        debugPrint('Hata: $e');
        // Hata durumunu state'e yansıtabilir ya da farklı bir şekilde kullanıcıya bildirebilirsiniz
      }
    });
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
