import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/blocs/bloc_status.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    bool isUser = FirebaseAuth.instance.currentUser != null;
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.appStatus) {
            case InitialStatus() || SubmissionLoading():
              return const Center(child: CircularProgressIndicator());
            case SubmissionSuccess() || FormSubmitting():
              return Scaffold(
                body: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: isUser
                        ? CameraPosition(
                            target: LatLng(state.user?.lat ?? 38.423733,
                                state.user?.lng ?? 27.142826),
                            zoom: 14)
                        : _kGooglePlex,
                    markers: getMarkers(state.problems, context),
                    onMapCreated: (GoogleMapController controller) {
                      BlocProvider.of<HomeBloc>(context)
                          .add(HomeMapCreated(controller: controller));
                    }),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startFloat,
                floatingActionButton: isUser
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          context.router.push(const AddProblemRoute());
                        },
                        label: Text(context.loc.reportProblem),
                        icon: const Icon(Icons.report_problem),
                      )
                    : const SizedBox.shrink(),
              );
            default:
              return Container();
          }
        });
  }

  Set<Marker> getMarkers(
      List<Map<String, dynamic>> problemsData, BuildContext context) {
    return Set<Marker>.of(problemsData.map((problem) {
      return Marker(
        markerId: MarkerId("${problem['lat']}${problem['lng']}"),
        position: LatLng(problem['lat'], problem['lng']),
        infoWindow: InfoWindow(
          title: problem['title'],
          snippet: problem['description'],
        ),
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: context.verticalPaddingLow +
                      context.horizontalPaddingMedium,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: context.horizontalPaddingHigh,
                              child: const Divider(
                                thickness: 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              context.loc.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(problem["title"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              context.loc.description,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(problem["description"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        context.loc.problemPictures,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Column(
                          children: List.generate(
                            problem['imageUrls'].length,
                            (index) => GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => Dialog(
                                    child: Image.network(
                                      problem['imageUrls'][index],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.network(
                                  problem['imageUrls'][index],
                                  height: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }));
  }
}
