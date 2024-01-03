// import 'package:auto_route/auto_route.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sorun_bildirim_uygulamasi/app/views/home/view/home_view.dart';
// import 'package:sorun_bildirim_uygulamasi/app/views/login/view/login_view.dart';

// @RoutePage()
// class AuthenticationView extends StatelessWidget {
//   const AuthenticationView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return const HomeView();
//           } else {
//             return const LoginView();
//           }
//         },
//       ),
//     );
//   }
// }
