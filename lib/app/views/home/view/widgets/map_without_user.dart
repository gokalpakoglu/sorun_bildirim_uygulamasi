import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';

class MapWithOutUser extends StatefulWidget {
  const MapWithOutUser({
    super.key,
    required this.problems,
    required CameraPosition kGooglePlex,
  }) : _kGooglePlex = kGooglePlex;

  final Future<List<Map<String, dynamic>>> problems;
  final CameraPosition _kGooglePlex;

  @override
  State<MapWithOutUser> createState() => _MapWithOutUserState();
}

class _MapWithOutUserState extends State<MapWithOutUser> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            body: FutureBuilder(
                future: widget.problems,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<Map<String, dynamic>> problemsData = snapshot.data!;
                      // Haritadaki marker'ları oluşturun
                      Set<Marker> markers =
                          Set<Marker>.of(problemsData.map((problem) {
                        return Marker(
                          onTap: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: context.verticalPaddingLow +
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
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(Icons.close),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                "Problem title",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(problem["title"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                "Problem description",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  problem["description"],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          "Problem Pictures:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                                                        problem['imageUrls']
                                                            [index],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
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
                          markerId: const MarkerId(""), // ID'yi belirtin
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
                          initialCameraPosition: widget._kGooglePlex,
                          markers: markers,
                          onMapCreated: (GoogleMapController controller) {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeMapCreated(controller: controller));
                          });
                    } else {
                      return GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: widget._kGooglePlex,
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
