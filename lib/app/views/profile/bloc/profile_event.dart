part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class ProfileNameChanged extends ProfileEvent {
  ProfileNameChanged({this.name});
  final String? name;
  @override
  List<Object?> get props => [name];
}

class ProfileSurnameChanged extends ProfileEvent {
  ProfileSurnameChanged({this.surname});
  final String? surname;
  @override
  List<Object?> get props => [surname];
}
class ProfileLatLngChanged extends ProfileEvent {
  ProfileLatLngChanged();

  @override
  List<Object?> get props => [];
}

class ProfileMapCreated extends ProfileEvent {
  ProfileMapCreated({required this.controller});
  final GoogleMapController controller;
  @override
  List<Object?> get props => [controller];
}

class ProfileAnimateCamera extends ProfileEvent {
  ProfileAnimateCamera({required this.cameraPosition});
  final CameraPosition cameraPosition;
  @override
  List<Object?> get props => [cameraPosition];
}


class ProfileSubmitted extends ProfileEvent {
  @override
  List<Object> get props => [];
}
