part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.emailErrorMsg,
    this.passwordErrorMsg,
    this.nameErrorMsg,
    this.surnameErrorMsg,
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
  bool get isValidEmail => email.isNotEmpty && email.contains("@");

  final String password;
  bool get isValidPassword => password.length > 5;

  final String name;
  bool get isValidName => name.isNotEmpty;
  final String surname;
  bool get isValidSurname => surname.isNotEmpty;

  final String? emailErrorMsg;
  final String? passwordErrorMsg;
  final String? nameErrorMsg;
  final String? surnameErrorMsg;

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
      String? emailErrorMsg,
      String? passwordErrorMsg,
      String? nameErrorMsg,
      String? surnameErrorMsg,
      double? lat,
      double? lng,
      Set<Marker>? marker}) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      appStatus: appStatus ?? this.appStatus,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      emailErrorMsg: email != null ? '' : emailErrorMsg,
      passwordErrorMsg: password != null ? '' : passwordErrorMsg,
      nameErrorMsg: name != null ? '' : nameErrorMsg,
      surnameErrorMsg: surname != null ? '' : surnameErrorMsg,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      marker: marker ?? this.marker,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        appStatus,
        name,
        surname,
        lat,
        lng,
        marker,
        emailErrorMsg,
        passwordErrorMsg,
        nameErrorMsg,
        surnameErrorMsg
      ];
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
