part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class SelectLanguage extends AppSettingsEvent {
  const SelectLanguage({this.languages, this.locale});
  final Locale? locale;
  final Languages? languages;
  @override
  List<Object> get props => [locale!, languages!];
}

class SelectTheme extends AppSettingsEvent {
  final AppTheme? appTheme;

  const SelectTheme({this.appTheme});

  @override
  List<Object> get props => [appTheme!];
}
