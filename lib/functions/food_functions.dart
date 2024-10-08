import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/foods_model.dart';

class FoodFunctions {
  Future<List<Food>> getFoods() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/data.json');
      final List<dynamic> data = json.decode(response);

      return data.map((json) => Food.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }

  // Kategoriye göre düzenleme
  Future<List<Food>> getFoodsByCategory(String category) async {
    try {
      List<Food> foods = await getFoods();

      List<Food> filteredFoods =
          foods.where((food) => food.category == category).toList();

      return filteredFoods;
    } catch (e) {
      throw Exception('Bir hata oluştu: $e');
    }
  }
}
