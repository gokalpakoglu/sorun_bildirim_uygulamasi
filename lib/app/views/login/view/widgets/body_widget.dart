import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/bloc/login_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/register_view.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Email address'),
              const SizedBox(height: 5),
              TextFormField(
                onChanged: (value) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(LoginEmailChanged(email: value));
                  debugPrint(value);
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your email',
                    errorText: state.emailErrorMsg),
              ),
              const SizedBox(height: 5),
              const Text('Password'),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  BlocProvider.of<LoginBloc>(context)
                      .add(LoginPasswordChanged(password: value));
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    errorText: state.passwordErrorMsg),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (state.isValidEmail && state.isValidPassword)
                      ? () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LoginSubmitted());
                        }
                      : null,
                  child: Text(
                    state.appStatus.isLoading ? '.......' : 'Login',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't you have accounts yet? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const RegisterView();
                      }));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  // void _showEmailAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Empty Email!'),
  //           content: SingleChildScrollView(
  //               child: Column(children: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'))
  //           ]))));
  // }

  // void _showPasswordAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Empty Password!'),
  //           content: SingleChildScrollView(
  //               child: Column(children: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'))
  //           ]))));
  // }

  // void _showNotFoundAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //           title: const Text('User not found!'),
  //           content: SingleChildScrollView(
  //               child: Column(children: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'))
  //           ]))));
  // }

  // void _showWrongPassAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Wrong Password!'),
  //           content: SingleChildScrollView(
  //               child: Column(children: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'))
  //           ]))));
  // }

  // void _showInvalidEmailAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //           title: const Text('Invalid Email!'),
  //           content: SingleChildScrollView(
  //               child: Column(children: <Widget>[
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Text('OK'))
  //           ]))));
  // }
}
