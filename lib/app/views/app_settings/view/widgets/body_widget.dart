import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/bloc/app_settings_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
      List<AppTheme> themes = [
        AppTheme.lightTheme,
        AppTheme.darkTheme,
      ];
      List<bool> isSelectedTheme =
          themes.map((theme) => state.theme == theme).toList();

      List<bool> isSelectedLang = Languages.values
          .map((lang) => state.locale == lang.localeFromLanguage)
          .toList();

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.loc.selectTheme,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ToggleButtons(
              isSelected: isSelectedTheme,
              onPressed: (int newIndex) {
                context
                    .read<AppSettingsBloc>()
                    .add(ThemeChanged(appTheme: themes[newIndex]));
              },
              children: themes.map((theme) {
                IconData icon = theme == AppTheme.lightTheme
                    ? Icons.wb_sunny
                    : Icons.nightlight_round;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              context.loc.selectLanguage,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ToggleButtons(
              isSelected: isSelectedLang,
              onPressed: (int newIndex) {
                context.read<AppSettingsBloc>().add(LanguageChanged(
                    locale: (Languages.values[newIndex].localeFromLanguage),
                    languages: Languages.values[newIndex]));
              },
              children: Languages.values.map((lang) {
                String label = lang == Languages.english
                    ? context.loc.english
                    : context.loc.turkish;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(label),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
