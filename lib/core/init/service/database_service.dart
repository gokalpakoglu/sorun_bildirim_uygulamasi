import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/problem_model.dart';

class DatabaseService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addProblem(ProblemModel problemModel) async {
    try {
      CollectionReference problemsCollection =
          firebaseFirestore.collection("problems");
      await problemsCollection.add({
        'title': problemModel.title,
        'description': problemModel.description,
        'lat': problemModel.lat,
        'lng': problemModel.lng,
        'imageUrls': problemModel.imageUrls
      });
    } catch (e) {
      print(e);
    }
  }
}
