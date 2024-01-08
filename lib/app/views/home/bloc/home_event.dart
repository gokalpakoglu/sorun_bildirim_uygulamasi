part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class AddImages extends HomeEvent {
  final List<XFile> images;
  AddImages(this.images);
  @override
  List<Object> get props => [images];
}

class HomeTitleChanged extends HomeEvent {
  HomeTitleChanged({this.title});
  final String? title;
  @override
  List<Object?> get props => [title];
}

class HomeDescriptionChanged extends HomeEvent {
  HomeDescriptionChanged({this.description});
  final String? description;
  @override
  List<Object?> get props => [description];
}

class HomeLatLngChanged extends HomeEvent {
  HomeLatLngChanged();
  @override
  List<Object> get props => [];
}

class HomeMapCreated extends HomeEvent {
  HomeMapCreated({required this.controller});
  final GoogleMapController controller;
  @override
  List<Object?> get props => [controller];
}

class HomeAnimateCamera extends HomeEvent {
  HomeAnimateCamera({required this.cameraPosition});
  final CameraPosition cameraPosition;
  @override
  List<Object?> get props => [cameraPosition];
}

class InitialHome extends HomeEvent {
  InitialHome();
  @override
  List<Object?> get props => [];
}

class AddReportSubmitted extends HomeEvent {
  AddReportSubmitted();
  @override
  List<Object> get props => [];
}
