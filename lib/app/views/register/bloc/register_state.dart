part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = '',
    this.password = '',
    this.name = '',
    this.surname = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.appStatus = AppStatus.initial,
    this.marker = const {},
  });

  final String email;
  bool get isValidEmail => email.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;

  final String name;
  bool get isValidName => name.length > 0;
  final String surname;
  bool get isValidSurname => surname.length > 0;

  final double lat;
  final double lng;

  final AppStatus appStatus;

  final Set<Marker> marker;

  RegisterState copyWith(
      {String? email,
      String? password,
      AppStatus? appStatus,
      String? name,
      String? surname,
      double? lat,
      double? lng,
      Set<Marker>? marker}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      appStatus: appStatus ?? this.appStatus,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      marker: marker ?? this.marker,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, appStatus, name, surname, lat, lng, marker];
}

enum AppStatus {
  initial,
  loading,
  loaded,
  error;

  bool get isInitial => this == AppStatus.initial;
  bool get isLoading => this == AppStatus.loading;
  bool get isLoaded => this == AppStatus.loaded;
  bool get isError => this == AppStatus.error;
}
