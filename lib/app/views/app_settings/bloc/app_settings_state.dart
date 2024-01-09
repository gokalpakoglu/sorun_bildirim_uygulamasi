part of 'app_settings_bloc.dart';

enum Languages { turkish, english }

enum AppTheme { lightTheme, darkTheme, systemTheme }

extension LocaleFromLanguageExtension on Languages {
  Locale get localeFromLanguage {
    switch (this) {
      case Languages.english:
        return const Locale('en', 'US');
      case Languages.turkish:
        return const Locale('tr', 'TR');

      default:
        return const Locale('en', 'US');
    }
  }
}

extension ThemeFromThemeDataExtension on AppTheme {
  ThemeData? get fromTheme {
    switch (this) {
      case AppTheme.lightTheme:
        return AppThemes.appThemeData[AppTheme.lightTheme];
      case AppTheme.darkTheme:
        return AppThemes.appThemeData[AppTheme.darkTheme];
      default:
        return AppThemes.appThemeData[AppTheme.darkTheme];
    }
  }
}

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
