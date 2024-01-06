import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/view/login_view.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

@RoutePage()
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBarWidget(title: context.loc.profile),
            body: const BodyWidget(),
          );
        } else {
          return const LoginView();
        }
      },
    ));
  }
}
