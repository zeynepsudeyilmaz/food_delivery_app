import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/foods_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Food> _favorites = [];
  List<Food> get favorites => _favorites;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser!.uid;

  // Favorileri Firestore'da kaydet
  Future<void> saveFavoritesToFirestore() async {
    final colRef =
        _firestore.collection("users").doc(uid).collection("favorites");

    // Favori yiyecekleri Firestore'a kaydet
    for (var food in _favorites) {
      await colRef.doc(food.id).set({
        'id': food.id,
        'name': food.name,
        'price': food.price,
        'category': food.category,
        'image': food.image,
        'description': food.description,
      });
    }

    notifyListeners();
  }

  // Favorileri Firestore'dan çek
  Future<void> fetchFavoritesFromFirestore() async {
    final colRef =
        _firestore.collection("users").doc(uid).collection("favorites");

    final snapshot = await colRef.get();
    _favorites.clear();
    for (var doc in snapshot.docs) {
      _favorites.add(Food(
        id: doc.data()['id'],
        name: doc.data()['name'],
        price: doc.data()['price'],
        category: doc.data()['category'],
        image: doc.data()['image'],
        description: doc.data()['description'],
      ));
    }
    notifyListeners();
  }

  // Favori yiyecek ekle veya çıkar
  void toggleFavorite(Food food) {
    if (_favorites.contains(food)) {
      _favorites.remove(food);
      deleteFavoriteFromFirestore(food.id);
    } else {
      _favorites.add(food);
    }
    saveFavoritesToFirestore();
    notifyListeners();
  }

  // Firestore'dan favori yiyeceği sil
  Future<void> deleteFavoriteFromFirestore(String foodId) async {
    final colRef =
        _firestore.collection("users").doc(uid).collection("favorites");
    await colRef.doc(foodId).delete();
  }

  bool isExist(Food food) {
    return _favorites.contains(food);
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}
