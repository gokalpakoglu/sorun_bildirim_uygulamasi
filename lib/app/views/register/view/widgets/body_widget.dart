import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

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
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.appStatus == AppStatus.loaded) {
            context.router.push(const HomeRoute());
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
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
                      BlocProvider.of<RegisterBloc>(context)
                          .add(RegisterEmailChanged(email: value));
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.loc.enterYourEmail,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(context.loc.password),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bu alan boş kalamaz";
                      } else if (value.length < 6) {
                        return "Şifreniz 6 hanenin altında olamaz";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(RegisterPasswordChanged(password: value));
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.loc.enterYourPassword,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(context.loc.name),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bu alan boş kalamaz";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(RegisterNameChanged(name: value));
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.loc.enteryourName,
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 5),
                  Text(context.loc.surname),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Bu alan boş kalamaz";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      BlocProvider.of<RegisterBloc>(context)
                          .add(RegisterSurnameChanged(surname: value));
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: context.loc.enterYourSurname,
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(height: 5),
                  Text(context.loc.location),
                  ElevatedButton(
                      onPressed: () {
                        context.router.push(const GetCurrentLocationRoute());
                      },
                      child: Text(context.loc.getCurrentLocation)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (state.isValidEmail &&
                              state.isValidPassword &&
                              state.isValidName &&
                              state.isValidSurname)
                          ? () async {
                              try {
                                BlocProvider.of<RegisterBloc>(context)
                                    .add(RegisterSubmitted());
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                          title: Text("Hata"),
                                          content: Text(
                                              "Kayıt işlemi başarısız oldu!"),
                                        ));
                              }
                            }
                          : null,
                      child: Text(
                        context.loc.signup,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
