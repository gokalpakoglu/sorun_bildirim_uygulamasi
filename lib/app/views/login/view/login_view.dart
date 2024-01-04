import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  // Text Controllers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Login Page"),
      body: BodyWidget(),
    );
  }
}
