part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.nameErrorMsg,
    this.surnameErrorMsg,
    this.name = '',
    this.surname = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.appStatus = AppStatus.initial,
    this.marker = const {},
  });

  final String name;
  bool get isValidName => name.isNotEmpty;
  final String surname;
  bool get isValidSurname => surname.isNotEmpty;

  final double lat;
  final double lng;

  final String? nameErrorMsg;
  final String? surnameErrorMsg;

  final AppStatus appStatus;

  final Set<Marker> marker;

  ProfileState copyWith(
      {AppStatus? appStatus,
      String? name,
      String? surname,
      String? nameErrorMsg,
      String? surnameErrorMsg,
      double? lat,
      double? lng,
      Set<Marker>? marker}) {
    return ProfileState(
      appStatus: appStatus ?? this.appStatus,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      nameErrorMsg: name != null ? '' : nameErrorMsg,
      surnameErrorMsg: surname != null ? '' : surnameErrorMsg,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      marker: marker ?? this.marker,
    );
  }

  @override
  List<Object?> get props => [
        appStatus,
        name,
        surname,
        lat,
        lng,
        marker,
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
