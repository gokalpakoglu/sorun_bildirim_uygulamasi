part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.images = const [],
    this.title = '',
    this.description = '',
    this.titleErrorMsg,
    this.descriptionErrorMsg,
    this.appStatus = AppStatus.initial,
    this.lat = 0.0,
    this.lng = 0.0,
    this.marker = const {},
  });
  final String title;
  bool get isValidTitle => title.isNotEmpty;
  final String description;
  bool get isValidDescription => description.isNotEmpty;
  final String? titleErrorMsg;
  final String? descriptionErrorMsg;
  final AppStatus appStatus;
  final double lat;
  final double lng;
  final Set<Marker> marker;
  final List images;
  HomeState copyWith(
      {String? title,
      String? description,
      String? titleErrorMsg,
      String? descriptionErrorMsg,
      AppStatus? appStatus,
      double? lat,
      double? lng,
      Set<Marker>? marker,
      List? images}) {
    return HomeState(
        title: title ?? this.title,
        description: description ?? this.description,
        titleErrorMsg: title != null ? '' : this.titleErrorMsg,
        descriptionErrorMsg:
            description != null ? '' : this.descriptionErrorMsg,
        appStatus: appStatus ?? this.appStatus,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        marker: marker ?? this.marker,
        images: images ?? this.images);
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
        images
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
