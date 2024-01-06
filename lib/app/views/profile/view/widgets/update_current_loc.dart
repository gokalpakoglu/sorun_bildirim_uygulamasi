import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

@RoutePage()
class UpdateCurrentLocationView extends StatefulWidget {
  const UpdateCurrentLocationView({super.key});

  @override
  State<UpdateCurrentLocationView> createState() =>
      _UpdateCurrentLocationViewState();
}

class _UpdateCurrentLocationViewState extends State<UpdateCurrentLocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.getCurrentLocation)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          debugPrint(state.marker.toString());
          return GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(state.lat, state.lng), zoom: 10),
            markers: state.marker,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              BlocProvider.of<ProfileBloc>(context)
                  .add(ProfileMapCreated(controller: controller));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          BlocProvider.of<ProfileBloc>(context).add(ProfileLatLngChanged());
        },
        label: Text(context.loc.location),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
