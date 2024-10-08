import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/order_model.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get _uid => _auth.currentUser!.uid;

  Future<void> addOrder(Orders order) async {
    try {
      await _db
          .collection('users')
          .doc(_uid)
          .collection("orders")
          .add(order.toJson());
    } catch (e) {
      throw Exception("Sipariş eklenirken hata: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    List<Map<String, dynamic>> orders = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("users").doc(_uid).collection("orders").get();

      orders = snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception("Siparişleri alırken hata: $e");
    }
    return orders;
  }
}
