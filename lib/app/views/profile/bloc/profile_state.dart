part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user,
    this.nameErrorMsg = '',
    this.surnameErrorMsg = '',
    this.name,
    this.surname,
    this.lat,
    this.lng,
    this.appStatus = const InitialStatus(),
    this.marker = const {},
    this.message = '',
  });

  final String? name;
  bool get isValidName => name?.isNotEmpty ?? false;
  final String? surname;
  bool get isValidSurname => surname?.isNotEmpty ?? false;

  final double? lat;
  final double? lng;

  final String nameErrorMsg;
  final String surnameErrorMsg;
  final String message;

  final AppSubmissionStatus appStatus;
  final AppUser? user;

  final Set<Marker> marker;

  ProfileState copyWith(
      {AppSubmissionStatus? appStatus,
      String? name,
      String? surname,
      String? nameErrorMsg,
      String? surnameErrorMsg,
      String? message,
      double? lat,
      double? lng,
      AppUser? user,
      Set<Marker>? marker}) {
    return ProfileState(
      appStatus: appStatus ?? this.appStatus,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      nameErrorMsg: name != null ? '' : this.nameErrorMsg,
      surnameErrorMsg: surname != null ? '' : this.surnameErrorMsg,
      message: message ?? this.message,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      marker: marker ?? this.marker,
      user: user ?? this.user,
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
        surnameErrorMsg,
        message,
        user
      ];
}
