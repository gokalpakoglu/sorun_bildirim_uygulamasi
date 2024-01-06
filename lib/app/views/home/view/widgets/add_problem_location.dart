import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

@RoutePage()
class AddProblemLocationView extends StatefulWidget {
  const AddProblemLocationView({super.key});

  @override
  State<AddProblemLocationView> createState() => _AddProblemLocationViewState();
}

class _AddProblemLocationViewState extends State<AddProblemLocationView> {
  @override
  Widget build(BuildContext context) {
    var user = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.getCurrentLocation)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          debugPrint(state.marker.toString());
          return StreamBuilder(
              stream: user.snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target:
                          LatLng(snapshot.data["lat"], snapshot.data["lng"]),
                      zoom: 14),
                  markers: state.marker,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomeMapCreated(controller: controller));
                  },
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          BlocProvider.of<HomeBloc>(context).add(HomeLatLngChanged());
        },
        label: Text(context.loc.location),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
