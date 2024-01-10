import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.appStatus != current.appStatus,
      listener: (context, state) {
        var formStatus = state.appStatus;
        if (formStatus is FormSubmitting) {
          _showSuccessDialog(context.loc.successTitle, state.message, context);
        } else if (formStatus is SubmissionFailed) {
          _showErrorDialog(context.loc.errorTitle, state.message, context);
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(context.loc.name),
                        const SizedBox(height: 5),
                        CustomTextFormField(
                          maxLines: 1,
                          enabled: true,
                          initialValue: state.user?.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.emptyField;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileNameChanged(name: value));
                          },
                          obscureText: false,
                        ),
                        const SizedBox(height: 5),
                        Text(context.loc.surname),
                        CustomTextFormField(
                          maxLines: 1,
                          enabled: true,
                          initialValue: state.user?.surname,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.loc.emptyField;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileSurnameChanged(surname: value));
                          },
                          obscureText: false,
                        ),
                        const SizedBox(height: 5),
                        Text(context.loc.location),
                        CustomTextFormField(
                          maxLines: 1,
                          onChanged: (value) {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(ProfileLatLngChanged());
                          },
                          obscureText: false,
                          enabled: false,
                          labelText:
                              "${state.user?.lat.toString()},${state.user?.lng.toString()}",
                        ),
                        const SizedBox(height: 5),
                        CustomElevatedButton(
                          text: context.loc.getCurrentLocation,
                          onPressed: () {
                            context.router
                                .push(const UpdateCurrentLocationRoute());
                          },
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: CustomElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ProfileBloc>(context)
                                  .add(ProfileSubmitted());
                            },
                            text: state.appStatus is SubmissionLoading
                                ? '.......'
                                : context.loc.update,
                          ),
                        ),
                      ],
                    )),
              ),
            );
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
            child: Text(context.loc.ok),
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
            child: Text(context.loc.ok),
          ),
        ],
      );
    },
  );
}
