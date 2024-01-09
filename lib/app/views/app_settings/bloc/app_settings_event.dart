part of 'app_settings_bloc.dart';

abstract class AppSettingsEvent extends Equatable {
  const AppSettingsEvent();

  @override
  List<Object> get props => [];
}

class LanguageChanged extends AppSettingsEvent {
  const LanguageChanged({this.languages, this.locale});
  final Locale? locale;
  final Languages? languages;
  @override
  List<Object> get props => [locale!, languages!];
}

class ThemeChanged extends AppSettingsEvent {
  final AppTheme? appTheme;

  const ThemeChanged({this.appTheme});

  @override
  List<Object> get props => [appTheme!];
}

class InitialAppSettings extends AppSettingsEvent {
  const InitialAppSettings();
  @override
  List<Object> get props => [];
}
