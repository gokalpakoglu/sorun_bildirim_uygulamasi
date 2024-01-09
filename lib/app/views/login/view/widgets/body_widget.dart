import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/bloc/login_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/custom_elevated_button.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/custom_text_form_field.dart';
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
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.appStatus != current.appStatus,
      listener: (context, state) {
        var formStatus = state.appStatus;
        if (formStatus is SubmissionSuccess) {
          context.router
              .pushAndPopUntil(const MainRoute(), predicate: (_) => false);
        } else if (formStatus is SubmissionFailed) {
          _showErrorDialog(context.loc.errorTitle, state.message, context);
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
                  CustomTextFormField(
                    maxLines: 1,
                    enabled: true,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.loc.emptyField;
                      } else if (!value.contains("@")) {
                        return context.loc.validEmail;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginEmailChanged(email: value));
                    },
                    hintText: context.loc.enterYourEmail,
                  ),
                  const SizedBox(height: 5),
                  Text(context.loc.password),
                  CustomTextFormField(
                    maxLines: 1,
                    enabled: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.loc.emptyField;
                      } else if (value.length < 6) {
                        return context.loc.passwordLength;
                      }
                      return null;
                    },
                    obscureText: true,
                    onChanged: (value) {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginPasswordChanged(password: value));
                    },
                    hintText: context.loc.enterYourPassword,
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
                    child: CustomElevatedButton(
                      text: (state.appStatus is SubmissionLoading)
                          ? '.......'
                          : context.loc.login,
                      onPressed: (state.isValidEmail && state.isValidPassword)
                          ? () async {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginSubmitted());
                            }
                          : null,
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
              child: Text(context.loc.ok),
            ),
          ],
        );
      },
    );
  }
}
