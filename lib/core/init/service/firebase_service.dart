import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  Future<AppUser?> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw ArgumentError('No user found for the given credentials!');
      }
      // else {
      //   return AppUser(
      //       email: firebaseUser.email,
      //       password: password,
      //       name: firebaseUser.d,
      //       surname: surname,
      //       lat: firebaseUser.,
      //       lng: lng);
      // }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<AppUser?> registerUser(AppUser user) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email.trim(), password: user.password.trim());
      await _store.collection("users").doc(_auth.currentUser!.uid).set({
        "name": user.name,
        "surname": user.surname,
        "email": user.email,
        "lat": user.lat,
        "lng": user.lng,
      });
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return AppUser(
          name: user.name,
          email: user.email,
          surname: user.surname,
          lat: user.lat,
          lng: user.lng,
          password: user.password,
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      await _auth.signOut();
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<String?> getIdToken() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return await user.getIdToken();
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}
//   // Method to register user
//   Future<AppUser?> registerUser(
//       {required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//       return null;
//     }
//   }

