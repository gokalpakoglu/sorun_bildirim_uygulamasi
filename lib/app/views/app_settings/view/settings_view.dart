import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';
@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Settings Page"),
      body: BodyWidget(),
    );
  }
}
