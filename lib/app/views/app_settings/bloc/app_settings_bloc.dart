import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/app_themes.dart';
part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final ThemeData? themeData;
  final AppTheme? selectedTheme;
  final Locale? locale;
  final Languages? selectedLanguage;
  AppSettingsBloc(
      {this.selectedLanguage, this.themeData, this.selectedTheme, this.locale})
      : super(
          AppSettingsState(
            languages: selectedLanguage,
            locale: locale,
            theme: selectedTheme,
            themeData: themeData,
          ),
        ) {
    on<SelectLanguage>(
      (event, emit) async {
        emit(state.copyWith(locale: event.locale));
      },
    );
    on<SelectTheme>(
      (event, emit) async {
        emit(state.copyWith(theme: event.appTheme));
        emit(
          state.copyWith(
            themeData: event.appTheme != AppTheme.systemTheme
                ? AppThemes.appThemeData[event.appTheme]
                // ignore: deprecated_member_use
                : WidgetsBinding.instance.window.platformBrightness ==
                        Brightness.dark
                    ? AppThemes.appThemeData[AppTheme.darkTheme]
                    : AppThemes.appThemeData[AppTheme.lightTheme],
          ),
        );
      },
    );
  }
}
