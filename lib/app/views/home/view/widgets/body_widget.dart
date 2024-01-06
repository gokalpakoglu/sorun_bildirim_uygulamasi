import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
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
    Future<List<Map<String, dynamic>>> problems = getProblemsFromFirebase();

    if (FirebaseAuth.instance.currentUser != null) {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          var user = FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid);
          return Scaffold(
              body: StreamBuilder(
                stream: user.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return FutureBuilder(
                        future: problems,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                problemSnapshot) {
                          if (problemSnapshot.connectionState ==
                              ConnectionState.done) {
                            if (problemSnapshot.hasData &&
                                problemSnapshot.data!.isNotEmpty) {
                              List<Map<String, dynamic>> problemsData =
                                  problemSnapshot.data!;
                              // Haritadaki marker'ları oluşturun
                              Set<Marker> markers =
                                  Set<Marker>.of(problemsData.map((problem) {
                                return Marker(
                                  markerId:
                                      const MarkerId(""), // ID'yi belirtin
                                  position: LatLng(problem['lat'],
                                      problem['lng']), // Konumu belirtin
                                  infoWindow: InfoWindow(
                                    title: problem['title'], // Başlık
                                    snippet: problem['description'], // Açıklama
                                  ),
                                  onTap: () {
                                    // showModalBottomSheet(
                                    //   useSafeArea: true,
                                    //   backgroundColor: context.theme.cardColor,
                                    //   isScrollControlled: true,
                                    //   shape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.vertical(
                                    //       top: Radius.circular(20),
                                    //     ),
                                    //   ),
                                    //   context: context,
                                    //   builder: (context) =>
                                    //       SingleChildScrollView(
                                    //     padding: context.paddingLow,
                                    //     child: Column(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceAround,
                                    //       children: [
                                    //         Padding(
                                    //           padding: context
                                    //                   .horizontalPaddingHigh *
                                    //               2,
                                    //           child: Divider(
                                    //             thickness: 3,
                                    //             color: context
                                    //                 .theme.secondaryHeaderColor,
                                    //           ),
                                    //         ),
                                    //         Wrap(
                                    //           alignment: WrapAlignment.center,
                                    //           runSpacing: context.mediumValue,
                                    //           children: [
                                    //             Row(
                                    //               children: [
                                    //                 const Expanded(
                                    //                     child: Text("Title:")),
                                    //                 Expanded(
                                    //                     child: Text(
                                    //                         problem["title"])),
                                    //               ],
                                    //             ),
                                    //             Row(
                                    //               children: [
                                    //                 const Expanded(
                                    //                     child: Text(
                                    //                         "Description:")),
                                    //                 Expanded(
                                    //                     child: Text(problem[
                                    //                         "description"])),
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         SizedBox(
                                    //           height: context.height * 0.2,
                                    //           width: context.width * 0.4,
                                    //           child: ListView.builder(
                                    //             itemCount:
                                    //                 problem['imageUrls'].length,
                                    //             itemBuilder: (context, index) {
                                    //               return Padding(
                                    //                 padding: EdgeInsets.all(
                                    //                     context.lowValue),
                                    //                 child: GestureDetector(
                                    //                   onTap: () {
                                    //                     // Resmin tıklanma işlemini buraya ekleyebilirsiniz
                                    //                   },
                                    //                   child: Image.network(
                                    //                     problem['imageUrls']
                                    //                         [index],
                                    //                     width:
                                    //                         context.width * 0.3,
                                    //                     fit: BoxFit.cover,
                                    //                   ),
                                    //                 ),
                                    //               );
                                    //             },
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // );

                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Padding(
                                            padding: context
                                                    .verticalPaddingLow +
                                                context.horizontalPaddingMedium,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Padding(
                                                        padding: context
                                                            .horizontalPaddingHigh,
                                                        child: const Divider(
                                                          thickness: 3,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 0,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Icon(
                                                            Icons.close),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Expanded(
                                                      child: Text(
                                                        "Problem title",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          problem["title"],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Expanded(
                                                      child: Text(
                                                        "Problem description",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          problem[
                                                              "description"],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Problem Pictures:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 8),
                                                Center(
                                                  child: Column(
                                                    children: List.generate(
                                                      problem['imageUrls']
                                                          .length,
                                                      (index) =>
                                                          GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                            context: context,
                                                            builder: (_) =>
                                                                Dialog(
                                                              child:
                                                                  Image.network(
                                                                problem['imageUrls']
                                                                    [index],
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Image.network(
                                                            problem['imageUrls']
                                                                [index],
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
                              return GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(snapshot.data["lat"],
                                          snapshot.data["lng"]),
                                      zoom: 14),
                                  markers: markers,
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HomeMapCreated(controller: controller));
                                  });
                            } else {
                              return GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(snapshot.data["lat"],
                                          snapshot.data["lng"]),
                                      zoom: 14),
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    BlocProvider.of<HomeBloc>(context).add(
                                        HomeMapCreated(controller: controller));
                                  });
                            }
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        });
                  } else {
                    return const Text('Lütfen bir konuma tıklayın');
                  }
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startDocked,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  context.router.push(const AddProblemRoute());
                },
                label: const Text('Sorun Bildir'),
                icon: const Icon(Icons.report_problem),
              ));
        },
      );
    } else {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              body: FutureBuilder(
                  future: problems,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        List<Map<String, dynamic>> problemsData =
                            snapshot.data!;
                        // Haritadaki marker'ları oluşturun
                        Set<Marker> markers =
                            Set<Marker>.of(problemsData.map((problem) {
                          return Marker(
                            markerId: MarkerId(""), // ID'yi belirtin
                            position: LatLng(problem['lat'],
                                problem['lng']), // Konumu belirtin
                            infoWindow: InfoWindow(
                              title: problem['title'], // Başlık
                              snippet: problem['description'], // Açıklama
                            ),
                          );
                        }));
                        return GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            markers: markers,
                            onMapCreated: (GoogleMapController controller) {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(HomeMapCreated(controller: controller));
                            });
                      } else {
                        return GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(HomeMapCreated(controller: controller));
                            });
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startDocked,
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Hata"),
                      content: const Text("Lütfen giriş yapınız."),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Tamam"))
                      ],
                    ),
                  );
                },
                label: const Text('Sorun Bildir'),
                icon: const Icon(Icons.report_problem),
              ));
        },
      );
    }
  }
}

Future<List<Map<String, dynamic>>> getProblemsFromFirebase() async {
  List<Map<String, dynamic>> problems = [];

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('problems').get();

    for (var doc in snapshot.docs) {
      problems.add(doc.data());
    }

    return problems;
  } catch (e) {
    print('Veri alınırken bir hata oluştu: $e');
    return problems;
  }
}
