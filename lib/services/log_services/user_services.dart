import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../models/user_model.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Email ve şifre ile kayıt
  Future<void> registerWithEmailPassword(
      String email, String password, UserModel user) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // Kullanıcı bilgilerini Firestore'a kaydet
    await _firestore.collection("users").doc(userCredential.user!.uid).set({
      "uid": userCredential.user!.uid,
      "email": user.email,
      "name": user.name,
      "phoneNumber": user.phoneNumber,
      "birthDate": user.birthDate,
      "createdDate": FieldValue.serverTimestamp(),
    });
  }

  // E-posta ve şifre ile oturum açma
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Hata mesajını döndür
      throw Exception(e.message);
    }
  }

  // Google ile oturum açma
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Google ile oturum açma işlemini başlat
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // Kullanıcı Google girişini iptal etti
        throw Exception('Google girişini iptal etti.');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Firebase ile Google kullanıcı bilgilerini doğrulama
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase ile oturum aç
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception('Google ile oturum açma hatası: ${e.message}');
    } catch (e) {
      throw Exception('Hata: ${e.toString()}');
    }
  }

  // Kullanıcı verilerini çekme
  Future<UserModel?> getUserData(String uid) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("users").doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Kullanıcı güncelleme
  Future<void> updateUser(String uid, UserModel user) async {
    await _firestore.collection("users").doc(uid).update(user.toMap());
  }

  // Kullanıcı silme
  Future<void> deleteUser(String uid) async {
    await _firestore.collection("users").doc(uid).delete();
  }

  // Oturumu kapatma
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Hata durumunda fırlatma
      throw Exception('Oturum kapatma hatası: ${e.toString()}');
    }
  }

  // Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception('Şifre sıfırlama hatası: ${e.message}');
    } catch (e) {
      throw Exception('Hata: ${e.toString()}');
    }
  }

  // Şifre güncelleme
  Future<void> updatePassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
        await user.reload();
        user = _auth.currentUser;
      } on FirebaseAuthException catch (e) {
        throw Exception('Şifre güncelleme hatası: ${e.message}');
      }
    } else {
      throw Exception('Kullanıcı giriş yapmamış');
    }
  }
}
