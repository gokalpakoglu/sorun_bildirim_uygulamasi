import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/authentication/bloc/view/authentication_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthenticationView(),
    );
  }
}


  // void createUserEmailandPassword() async {
  //   try {
  //     var _userCredential = await auth.createUserWithEmailAndPassword(
  //         email: _email, password: _password);

  //     debugPrint(_userCredential.toString());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // void loginUserEmailandPassword() async {
  //   try {
  //     var _userCredential = await auth.signInWithEmailAndPassword(
  //         email: _email, password: _password);
  //     debugPrint(_userCredential.toString());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // void signOut() async {
  //   await auth.signOut();
  // }

  // void deleteUser() async {
  //   if (auth.currentUser != null) {
  //     await auth.currentUser!.delete();
  //   } else {
  //     debugPrint("Kullanıcı oturum açmadığı için silinemez");
  //   }
  // }

  // void changePassword() async {
  //   try {
  //     await auth.currentUser!.updatePassword("yenisifre");
  //     await auth.signOut();
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "requires-recent-login") {
  //       var credential =
  //           EmailAuthProvider.credential(email: _email, password: _password);
  //       auth.currentUser!.reauthenticateWithCredential(credential);
  //       await auth.currentUser!.updatePassword("yenisifre");
  //       await auth.signOut();
  //       debugPrint("şifre güncellendi");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

