import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //adres kaydetme
  Future<void> addAddress(String addressName, String address) async {
    String uid = _auth.currentUser!.uid;

    await _firestore.collection("users").doc(uid).collection("addresses").add({
      "addressName": addressName,
      "address": address,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getAddresses() {
    String uid = _auth.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('addresses')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Belge verisini al ve ID'yi ekle
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Belge ID'sini 'id' olarak ekle
        print('Address ID: ${doc.id}'); // ID'yi konsola yazdır
        return data;
      }).toList();
    });
  }

  // Adresi silmek için bir metot
  Future<void> deleteAddress(String addressId) async {
    String uid = _auth.currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('addresses')
        .doc(addressId) // Adresin ID'sini kullan
        .delete();
  }
}
