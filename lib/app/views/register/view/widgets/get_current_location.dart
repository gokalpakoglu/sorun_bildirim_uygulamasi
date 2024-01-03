import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';

class GetCurrentLocationView extends StatefulWidget {
  const GetCurrentLocationView({super.key});

  @override
  State<GetCurrentLocationView> createState() => _GetCurrentLocationViewState();
}

class _GetCurrentLocationViewState extends State<GetCurrentLocationView> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37, -122), zoom: 14);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Current Location')),
      body: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          debugPrint(state.marker.toString());
          return GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: state.marker,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterMapCreated(controller: controller));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          //

          BlocProvider.of<RegisterBloc>(context).add(RegisterLatLngChanged());
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}
