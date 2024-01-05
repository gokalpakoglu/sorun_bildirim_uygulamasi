import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/problem_model.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/database_service.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/service/firebase_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final auth = FirebaseAuthService();
  final Completer<GoogleMapController> mapController = Completer();
  final databaseService = DatabaseService();
  HomeBloc() : super(const HomeState()) {
    on<HomeTitleChanged>((event, emit) => emit(state.copyWith(
        title: event.title, titleErrorMsg: validateTitle(title: event.title))));
    on<HomeDescriptionChanged>((event, emit) => emit(state.copyWith(
          description: event.description,
          descriptionErrorMsg:
              validateDescription(description: event.description),
        )));
    on<HomeLatLngChanged>((event, emit) async {
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
    on<HomeMapCreated>((event, emit) {
      if (!mapController.isCompleted) {
        mapController.complete(event.controller);
      }
    });
    on<HomeAnimateCamera>((event, emit) async {});
    on<AddImages>((event, emit) {
      final List<dynamic> updatedImages = List.from(state.images)
        ..addAll(event.images);
      emit(state.copyWith(images: updatedImages));
    });
    on<AddReportSubmitted>((event, emit) async {
      try {
        List<String> imageUrls = [];

        for (var image in state.images) {
          String imageUrl = await uploadImageAndGetUrl(File(image.path));
          imageUrls.add(imageUrl);
        }

        ProblemModel model = ProblemModel(
          title: state.title,
          description: state.description,
          lat: state.lat,
          lng: state.lng,
          imageUrls: imageUrls,
        );
        await databaseService.addProblem(model);
        emit(state.copyWith(images: []));
      } catch (e) {
        print('Hata oluştu: $e');
      }
    });
  }
}

Future<String> uploadImageAndGetUrl(File imageFile) async {
  try {
    Reference reference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask.whenComplete(() {});

    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('Resim yükleme hatası: $e');
    return '';
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

String? validateTitle({String? title}) {
  if (title?.isEmpty ?? false) {
    return 'Title cannot be empty';
  } else {
    return null;
  }
}

String? validateDescription({String? description}) {
  if (description?.isEmpty ?? false) {
    return 'Description cannot be empty';
  } else {
    return null;
  }
}
