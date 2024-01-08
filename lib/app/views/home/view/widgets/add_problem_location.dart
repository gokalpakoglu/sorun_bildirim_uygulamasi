import 'package:auto_route/auto_route.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.getCurrentLocation)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(state.user?.lat ?? 0.0, state.user?.lng ?? 0.0),
                zoom: 14),
            markers: state.marker,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              BlocProvider.of<HomeBloc>(context)
                  .add(HomeMapCreated(controller: controller));
            },
          );
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
