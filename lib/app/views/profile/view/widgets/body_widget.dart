import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/widgets/get_current_location.dart';

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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text('Your Name'),
                    TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileNameChanged(name: value));
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: snapshot.data.data()["name"],
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(height: 5),
                    const Text('Your Surname'),
                    TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<ProfileBloc>(context)
                            .add(ProfileSurnameChanged(surname: value));
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: snapshot.data.data()["surname"],
                      ),
                      obscureText: false,
                    ),
                    const SizedBox(height: 5),
                    const Text('Your Location'),
                    TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<RegisterBloc>(context)
                            .add(RegisterLatLngChanged());
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const GetCurrentLocationView();
                          }));
                        },
                        child: const Text("Get Current Location")),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          state.appStatus.isLoading ? '.......' : 'Update',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(ProfileSubmitted());
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) {
                          //   return const HomeView();
                          // }));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
