import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';
@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: "Profile Page"),
      body: BodyWidget(),
    );
  }
}
