part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {}

class RegisterEmailChanged extends RegisterEvent {
  RegisterEmailChanged({this.email});
  final String? email;

  @override
  List<Object?> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  RegisterPasswordChanged({this.password});
  final String? password;
  @override
  List<Object?> get props => [password];
}

class RegisterNameChanged extends RegisterEvent {
  RegisterNameChanged({this.name});
  final String? name;
  @override
  List<Object?> get props => [name];
}

class RegisterSurnameChanged extends RegisterEvent {
  RegisterSurnameChanged({this.surname});
  final String? surname;
  @override
  List<Object?> get props => [surname];
}

class RegisterLatLngChanged extends RegisterEvent {
  RegisterLatLngChanged();

  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterMapCreated extends RegisterEvent {
  RegisterMapCreated({required this.controller});
  final GoogleMapController controller;
  @override
  List<Object?> get props => [controller];
}

class RegisterAnimateCamera extends RegisterEvent {
  RegisterAnimateCamera({required this.cameraPosition});
  final CameraPosition cameraPosition;
  @override
  List<Object?> get props => [cameraPosition];
}
