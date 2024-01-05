import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: context.loc.settingsPage),
      body: const BodyWidget(),
    );
  }
}
