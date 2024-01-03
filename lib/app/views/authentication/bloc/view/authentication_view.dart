import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/home_view.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/register_view.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});
  static String id = "main screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const SignupScreen();
          }
        },
      ),
    );
  }
}
