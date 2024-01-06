import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;
  final _store = FirebaseFirestore.instance;

  Future<AppUser?> registerUser(AppUser user) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
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

  Future<AppUser?> loginUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw ArgumentError('No user found for the given credentials!');
      }
      // Burada başarılı giriş durumunda dönüş yapabilirsiniz
      return AppUser(
        email: firebaseUser.email,
        // Diğer kullanıcı bilgileri
      );
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException durumunda hata yakalanabilir
      if (e.code == 'user-not-found') {
        // Kullanıcı bulunamadı hatası
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        // Yanlış şifre hatası
        print('Wrong password provided for that user.');
      }
      // Firebase tarafından gelen diğer hataların kontrolü burada yapılabilir
      print(e.toString());
      return null;
    }
  }

  Future<AppUser?> updateUser(AppUser user) async {
    try {
      await _store.collection("users").doc(_auth.currentUser!.uid).update({
        "name": user.name,
        "surname": user.surname,
        "lat": user.lat,
        "lng": user.lng,
      });
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

  Future<bool> checkExistingUser(String email) async {
    try {
      var signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return signInMethods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Future<void> resetPassword({required String email}) async {
  //   try {
  //     await _auth.sendPasswordResetEmail(email: email);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //   }
  // }

  // User? getCurrentUser() {
  //   return _auth.currentUser;
  // }

  // Future<String?> getIdToken() async {
  //   try {
  //     User? user = _auth.currentUser;
  //     if (user != null) {
  //       return await user.getIdToken();
  //     } else {
  //       return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     return null;
  //   }
  // }
}
