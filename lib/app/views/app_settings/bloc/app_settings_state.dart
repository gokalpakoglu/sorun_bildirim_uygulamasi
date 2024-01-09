part of 'app_settings_bloc.dart';

enum Languages { turkish, english }

enum AppTheme { lightTheme, darkTheme, systemTheme }

class AppSettingsState extends Equatable {
  const AppSettingsState({
    this.theme,
    this.languages,
    this.locale,
    this.themeData,
  });

  final ThemeData? themeData;
  final Locale? locale;
  final Languages? languages;
  final AppTheme? theme;

  AppSettingsState copyWith({
    ThemeData? themeData,
    Locale? locale,
    Languages? languages,
    AppTheme? theme,
  }) {
    return AppSettingsState(
      themeData: themeData ?? this.themeData,
      locale: locale ?? this.locale,
      languages: languages ?? this.languages,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [themeData, locale, languages, theme];
}
