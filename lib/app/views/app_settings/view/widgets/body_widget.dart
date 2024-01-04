import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/app_themes.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/bloc/app_settings_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingMedium,
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ayarlar",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Diller",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Türkçe",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Radio<Languages>(
                        activeColor: context.theme.primaryColor,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: Languages.turkce,
                        groupValue:
                            context.watch<AppSettingsBloc>().state.language,
                        onChanged: (Languages? value) {
                          context.read<AppSettingsBloc>().add(
                                SelectLanguage(
                                  language: value,
                                  locale: const Locale("tr", "TR"),
                                ),
                              );
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "English",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Radio<Languages>(
                        activeColor: context.theme.primaryColor,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: Languages.english,
                        groupValue:
                            context.watch<AppSettingsBloc>().state.language,
                        onChanged: (Languages? value) {
                          context.read<AppSettingsBloc>().add(
                                SelectLanguage(
                                  language: value,
                                  locale: const Locale("en", "EN"),
                                ),
                              );
                        },
                      )
                    ],
                  )
                ],
              ),
              Text(
                "Tema",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Radio<AppTheme>(
                        activeColor: context.theme.primaryColor,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: AppTheme.systemTheme,
                        groupValue:
                            context.watch<AppSettingsBloc>().state.theme,
                        onChanged: (AppTheme? value) {
                          context.read<AppSettingsBloc>().add(
                                SelectTheme(
                                  appTheme: value,
                                ),
                              );
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Radio<AppTheme>(
                        activeColor: context.theme.primaryColor,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: AppTheme.lightTheme,
                        groupValue:
                            context.watch<AppSettingsBloc>().state.theme,
                        onChanged: (AppTheme? value) {
                          context.read<AppSettingsBloc>().add(
                                SelectTheme(
                                  appTheme: value,
                                ),
                              );
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Radio<AppTheme>(
                        activeColor: context.theme.primaryColor,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        value: AppTheme.darkTheme,
                        groupValue:
                            context.watch<AppSettingsBloc>().state.theme,
                        onChanged: (AppTheme? value) {
                          context.read<AppSettingsBloc>().add(
                                SelectTheme(
                                  appTheme: value,
                                ),
                              );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
