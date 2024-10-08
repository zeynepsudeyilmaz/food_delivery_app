import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/services/payment_services/encryption_servies.dart';

class CardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get _uid => _auth.currentUser!.uid;
  final EncryptionService _encryptionService = EncryptionService();

  Future<void> addCard(String cardHolderName, String cardNumber,
      String expiryDate, String cvvCode, String cardName) async {
    String encryptedCardNumber = _encryptionService.encryptData(cardNumber);
    String encryptedCvvCode = _encryptionService.encryptData(cvvCode);

    await _firestore.collection('users').doc(_uid).collection('cards').add({
      "cardHolderName": cardHolderName,
      "cardNumber": encryptedCardNumber,
      "expiryDate": expiryDate,
      "cvvCode": encryptedCvvCode,
      "cardName": cardName,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  //kart listeleme
  Future<List<Map<String, dynamic>>> getCards() async {
    List<Map<String, dynamic>> cards = [];
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cards')
        .get();

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      String decryptedCardNumber =
          _encryptionService.decryptData(data['cardNumber']);
      String decryptedCvvCode = _encryptionService.decryptData(data['cvvCode']);

      cards.add({
        "id": doc.id,
        "cardHolderName": data['cardHolderName'],
        "cardNumber": decryptedCardNumber,
        "expiryDate": data['expiryDate'],
        "cvvCode": decryptedCvvCode,
        "cardName": data['cardName'],
      });
    }
    return cards;
  }

  // Kart silme
  Future<void> deleteCard(String cardId) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cards')
          .doc(cardId)
          .delete();
    } catch (e) {
      print('Kart silinirken bir hata oluştu: $e');
    }
  }
}
