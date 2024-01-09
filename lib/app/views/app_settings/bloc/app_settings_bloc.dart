import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/app_themes.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/cache/cache_manager.dart';
part 'app_settings_event.dart';
part 'app_settings_state.dart';

class AppSettingsBloc extends Bloc<AppSettingsEvent, AppSettingsState> {
  final ThemeData? themeData;
  final AppTheme? theme;
  final Locale? locale;
  final Languages? selectedLanguage;

  AppSettingsBloc({
    this.selectedLanguage,
    this.themeData,
    this.theme,
    this.locale,
  }) : super(
          AppSettingsState(
            languages: selectedLanguage,
            locale: locale,
            theme: theme,
            themeData: themeData,
          ),
        ) {
    on<LanguageChanged>(
      (event, emit) async {
        emit(state.copyWith(locale: event.locale));
        emit(state.copyWith(languages: event.languages));

        Map<String, int> cache = {
          "language": event.languages!.index,
        };
        await CacheManager<Map<String, int>>()
            .writeData(key: CacheManagerEnum.language.name, value: cache);
        print("${CacheManagerEnum.language.name} is written to the cache.");
      },
    );

    on<ThemeChanged>(
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
        Map<String, int> cache = {
          "theme": event.appTheme!.index,
        };
        await CacheManager<Map<String, int>>()
            .writeData(key: CacheManagerEnum.theme.name, value: cache);
        print(
          "${CacheManagerEnum.theme.name} is written to the cache with index ${cache["theme"]}",
        );
      },
    );
    on<InitialAppSettings>((event, emit) async {
      final cachedThemeData = CacheManager<Map<String, dynamic>>()
          .readData(key: CacheManagerEnum.theme.name);
      final cachedLangData = CacheManager<Map<String, dynamic>>()
          .readData(key: CacheManagerEnum.language.name);

      if (cachedThemeData != null && cachedThemeData.containsKey('theme')) {
        final themeValue = cachedThemeData['theme'];
        if (themeValue is int) {
          emit(state.copyWith(
              theme: AppTheme.values[themeValue % AppTheme.values.length]));
        }
      }
      if (cachedLangData != null && cachedLangData.containsKey('language')) {
        final languageValue = cachedLangData['language'];
        if (languageValue is int) {
          emit(state.copyWith(
            locale: Languages
                    .values[languageValue % Languages.values.length.toInt()]
                as Locale,
          ));
        }
      }
      print(
        '${CacheManagerEnum.values} data read from the cache:\n'
        'Language: ${state.locale}\n'
        'Theme: ${state.theme}',
      );
      // final cachedTheme = await _getThemeFromCache();
      // final cachedLanguage = await _getLanguageFromCache();
      // emit(state.copyWith(
      //   //languages: Languages.values[cachedLanguage!],
      //   theme: AppTheme.values[cachedTheme!],
      //   themeData: themeData,
      // ));
    });
  }

  // Future<int?> _getThemeFromCache() async {
  //   final cachedData = CacheManager<Map<String, dynamic>>()
  //       .readData(key: CacheManagerEnum.theme.name);

  //   if (cachedData != null && cachedData.containsKey('theme')) {
  //     final themeValue = cachedData['theme'];
  //     if (themeValue is int) {
  //       return themeValue;
  //     }
  //   }
  //   return null;
  // }

  // Future<int?> _getLanguageFromCache() async {
  //   final cachedData = CacheManager<Map<String, dynamic>>()
  //       .readData(key: CacheManagerEnum.language.name);

  //   if (cachedData != null && cachedData.containsKey('language')) {
  //     final languageValue = cachedData['language'];
  //     if (languageValue is int) {
  //       return languageValue;
  //     }
  //   }
  //   return null;
  // }
}
