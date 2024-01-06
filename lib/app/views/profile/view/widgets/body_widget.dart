import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  var user = FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: user.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(context.loc.name),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bu alan boş kalamaz";
                            }
                            return null;
                          },
                          initialValue: snapshot.data.data()["name"],
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Bu alan boş kalamaz";
                            }
                            return null;
                          },
                          initialValue: snapshot.data.data()["surname"],
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
                                "${snapshot.data.data()["lat"]},${snapshot.data.data()["lng"]}",
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
                              state.appStatus.isLoading
                                  ? '.......'
                                  : context.loc.update,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
