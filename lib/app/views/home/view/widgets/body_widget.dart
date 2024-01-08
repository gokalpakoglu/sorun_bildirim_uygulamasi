import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/showModalProblems.dart';
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

  final Future<List<Map<String, dynamic>>> _problems =
      getProblemsFromFirebase();
  @override
  void initState() {
    getProblemsFromFirebase();
    _problems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isUser = FirebaseAuth.instance.currentUser != null;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        var user = FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser?.uid);
        return Scaffold(
          body: StreamBuilder(
            stream: user.snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return FutureBuilder(
                    future: _problems,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>>
                            problemSnapshot) {
                      if (problemSnapshot.connectionState ==
                          ConnectionState.done) {
                        if (problemSnapshot.hasData &&
                            problemSnapshot.data!.isNotEmpty) {
                          List<Map<String, dynamic>> problemsData =
                              problemSnapshot.data!;

                          Set<Marker> markers =
                              Set<Marker>.of(problemsData.map((problem) {
                            return Marker(
                              markerId: const MarkerId(""),
                              position: LatLng(problem['lat'], problem['lng']),
                              infoWindow: InfoWindow(
                                title: problem['title'],
                                snippet: problem['description'],
                              ),
                              onTap: () {
                                showModalProblems(context, problem);
                              },
                            );
                          }));
                          return GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: isUser
                                  ? CameraPosition(
                                      target: LatLng(snapshot.data["lat"],
                                          snapshot.data["lng"]),
                                      zoom: 14)
                                  : _kGooglePlex,
                              markers: markers,
                              onMapCreated: (GoogleMapController controller) {
                                BlocProvider.of<HomeBloc>(context).add(
                                    HomeMapCreated(controller: controller));
                              });
                        } else {
                          return GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: isUser
                                  ? CameraPosition(
                                      target: LatLng(snapshot.data["lat"],
                                          snapshot.data["lng"]),
                                      zoom: 14)
                                  : _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                BlocProvider.of<HomeBloc>(context).add(
                                    HomeMapCreated(controller: controller));
                              });
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
              } else {
                return const Text('Lütfen bir konuma tıklayın');
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          floatingActionButton: isUser
              ? FloatingActionButton.extended(
                  onPressed: () {
                    context.router.push(const AddProblemRoute());
                  },
                  label: const Text('Sorun Bildir'),
                  icon: const Icon(Icons.report_problem),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

Future<List<Map<String, dynamic>>> getProblemsFromFirebase() async {
  List<Map<String, dynamic>> problems = [];

  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('problems')
        .get()
        .timeout(const Duration(seconds: 20));

    for (var doc in snapshot.docs) {
      problems.add(doc.data());
    }

    return problems;
  } catch (e) {
    print('Veri alınırken bir hata oluştu: $e');
    return problems;
  }
}
