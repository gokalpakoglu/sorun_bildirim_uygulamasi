import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          onChanged: (value) {
            email = value;
          },
          decoration: const InputDecoration(hintText: 'Email'),
        ),
        TextField(
          onChanged: (value) {
            password = value;
          },
          decoration: const InputDecoration(hintText: 'Password'),
          obscureText: true,
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     try {
        //       final user = await _auth.signInWithEmailAndPassword(
        //           email: email, password: password);
        //       if (user != null) {
        //         // ignore: use_build_context_synchronously
        //         Navigator.pushReplacementNamed(context, '/home');
        //       }
        //     } catch (e) {
        //       debugPrint(e.toString());
        //     }
        //   },
        //   child: const Text('Login'),
        // ),
      ],
    );
  }
}
