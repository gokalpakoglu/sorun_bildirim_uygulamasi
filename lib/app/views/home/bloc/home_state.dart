part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user,
    this.images = const [],
    this.title = '',
    this.description = '',
    this.titleErrorMsg = '',
    this.descriptionErrorMsg = '',
    this.appStatus = const InitialStatus(),
    this.lat,
    this.lng,
    this.marker = const {},
    this.problems = const [],
    this.message = '',
  });
  final String title;
  bool get isValidTitle => title.isNotEmpty;
  final String description;
  bool get isValidDescription => description.isNotEmpty;
  final String titleErrorMsg;
  final String descriptionErrorMsg;
  final AppSubmissionStatus appStatus;
  final AppUser? user;
  final double? lat;
  final double? lng;
  final Set<Marker> marker;
  final List<Map<String, dynamic>> problems;
  final List images;
  final String message;
  HomeState copyWith({
    String? title,
    String? description,
    String? titleErrorMsg,
    String? descriptionErrorMsg,
    AppSubmissionStatus? appStatus,
    AppUser? user,
    double? lat,
    double? lng,
    Set<Marker>? marker,
    List? images,
    List<Map<String, dynamic>>? problems,
    String? message,
  }) {
    return HomeState(
      title: title ?? this.title,
      description: description ?? this.description,
      titleErrorMsg: title != null ? '' : this.titleErrorMsg,
      descriptionErrorMsg: description != null ? '' : this.descriptionErrorMsg,
      appStatus: appStatus ?? this.appStatus,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      marker: marker ?? this.marker,
      images: images ?? this.images,
      message: message ?? this.message,
      user: user ?? this.user,
      problems: problems ?? this.problems,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        titleErrorMsg,
        descriptionErrorMsg,
        appStatus,
        lat,
        lng,
        marker,
        images,
        message,
        user,
        problems
      ];
}
