import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
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
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.appStatus != current.appStatus,
      listener: (context, state) {
        var formStatus = state.appStatus;
        if (formStatus is FormSubmitting) {
          _showSuccessDialog("Başarılı", state.message, context);
        } else if (formStatus is SubmissionFailed) {
          _showErrorDialog("Hata", state.message, context);
        }
      },
      buildWhen: (previous, current) {
        return previous.user != current.user;
      },
      builder: (context, state) {
        switch (state.appStatus) {
          case InitialStatus() || SubmissionLoading():
            return const Center(child: CircularProgressIndicator());
          case SubmissionSuccess() || FormSubmitting():
            return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(context.loc.name),
                      TextFormField(
                        initialValue: state.user?.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bu alan boş kalamaz";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileNameChanged(name: value));
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorText: state.nameErrorMsg),
                        obscureText: false,
                      ),
                      const SizedBox(height: 5),
                      Text(context.loc.surname),
                      TextFormField(
                        initialValue: state.user?.surname,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Bu alan boş kalamaz";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileSurnameChanged(surname: value));
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            errorText: state.surnameErrorMsg),
                        obscureText: false,
                      ),
                      const SizedBox(height: 5),
                      Text(context.loc.location),
                      TextFormField(
                        onChanged: (value) {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileLatLngChanged());
                        },
                        decoration: InputDecoration(
                          enabled: false,
                          border: const OutlineInputBorder(),
                          labelText:
                              "${state.user?.lat.toString()},${state.user?.lng.toString()}",
                        ),
                        obscureText: false,
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                          onPressed: () {
                            context.router
                                .push(const UpdateCurrentLocationRoute());
                          },
                          child: Text(context.loc.getCurrentLocation)),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileSubmitted());
                          },
                          child: Text(
                            state.appStatus is SubmissionLoading
                                ? '.......'
                                : context.loc.update,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

void _showSuccessDialog(String title, String message, BuildContext context) {
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
