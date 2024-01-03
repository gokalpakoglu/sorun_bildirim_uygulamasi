import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/widgets/app_bar_widget.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/widgets/body_widget.dart';

@RoutePage()
class RegisterView extends StatelessWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  // Text Controllers
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  AppBarWidget(),
      body: BodyWidget(),
    );
  }
}
