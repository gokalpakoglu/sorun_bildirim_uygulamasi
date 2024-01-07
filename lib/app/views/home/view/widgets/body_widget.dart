import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/map_with_user.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/map_without_user.dart';

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
    if (FirebaseAuth.instance.currentUser != null) {
      return MapWithUser(problems: _problems);
    } else {
      return MapWithOutUser(problems: _problems, kGooglePlex: _kGooglePlex);
    }
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
