import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/showModalProblems.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

class MapWithUser extends StatefulWidget {
  const MapWithUser({
    super.key,
    required this.problems,
  });

  final Future<List<Map<String, dynamic>>> problems;

  @override
  State<MapWithUser> createState() => _MapWithUserState();
}

class _MapWithUserState extends State<MapWithUser> {
  Future<Uint8List> getMarkerIcon(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        // İndirme başarısız olduysa veya hatalı bir durum varsa boş bir Uint8List dönebiliriz.
        return Uint8List(0);
      }
    } catch (e) {
      // Hata durumunda boş bir Uint8List dönebiliriz.
      return Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      future: widget.problems,
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
                              // String imageUrl = problem['image_url'];
                              // Uint8List imageData = getMarkerIcon(imageUrl);
                              // BitmapDescriptor bitmapDescriptor =
                              //     BitmapDescriptor.fromBytes(imageData);
                              return Marker(
                                //icon: bitmapDescriptor,
                                markerId: const MarkerId(""), // ID'yi belirtin
                                position: LatLng(problem['lat'],
                                    problem['lng']), // Konumu belirtin
                                infoWindow: InfoWindow(
                                  title: problem['title'], // Başlık
                                  snippet: problem['description'], // Açıklama
                                ),
                                onTap: () {
                                  showModalProblems(context, problem);
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
                                onMapCreated: (GoogleMapController controller) {
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
                                onMapCreated: (GoogleMapController controller) {
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
  }
}
