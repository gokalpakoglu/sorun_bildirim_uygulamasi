import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/models/app_user.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStore = FirebaseFirestore.instance;

  Future<AppUser?> registerUser(AppUser user) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      await _firebaseStore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
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
      final UserCredential userCredential = await _firebaseAuth
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
      await _firebaseStore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
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
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }

// Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String email) async {
    try {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }
}
