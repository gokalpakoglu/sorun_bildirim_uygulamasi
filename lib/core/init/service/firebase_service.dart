import 'package:firebase_auth/firebase_auth.dart';
import 'package:sorun_bildirim_uygulamasi/core/models/app_user.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  Future<AppUser?> registerUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return AppUser(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            username: firebaseUser.displayName ?? '');
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

  Future<AppUser?> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw ArgumentError('No user found for the given credentials!');
      } else {
        return AppUser(
            id: firebaseUser.uid,
            email: firebaseUser.email!,
            username: firebaseUser.displayName!);
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
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

