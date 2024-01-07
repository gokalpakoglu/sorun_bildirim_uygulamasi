import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/bloc/login_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            previous.appStatus != current.appStatus,
        listener: (context, state) {
          var formStatus = state.appStatus;
          if (formStatus is SubmissionSuccess) {
            context.router
                .pushAndPopUntil(const MainRoute(), predicate: (_) => false);
          } else if (formStatus is SubmissionFailed) {
            _showErrorDialog("Hata", state.message, context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(context.loc.emailAddress),
                    const SizedBox(height: 5),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bu alan boş kalamaz";
                        } else if (!value.contains("@")) {
                          return "Lütfen geçerli bir e-posta adresi girin";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginEmailChanged(email: value));
                        debugPrint(value);
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: context.loc.enterYourEmail,
                          errorText: state.emailErrorMsg),
                    ),
                    const SizedBox(height: 5),
                    Text(context.loc.password),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bu alan boş kalamaz";
                        } else if (value.length < 6) {
                          return "Şifreniz 6 hanenin altında olamaz";
                        }
                        return null;
                      },
                      obscureText: true,
                      onChanged: (value) {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginPasswordChanged(password: value));
                      },
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: context.loc.enterYourPassword,
                          errorText: state.passwordErrorMsg),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        context.loc.forgotPassword,
                        style: const TextStyle(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {},
                        child: ElevatedButton(
                          onPressed:
                              (state.isValidEmail && state.isValidPassword)
                                  ? () async {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add(LoginSubmitted());
                                      print(state.appStatus);
                                    }
                                  : null,
                          child: Text(
                            (state.appStatus is SubmissionLoading)
                                ? '.......'
                                : context.loc.login,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.loc.haveAccounts),
                        GestureDetector(
                          onTap: () {
                            context.router.push(const RegisterRoute());
                          },
                          child: Text(
                            context.loc.register,
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
