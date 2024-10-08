import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/functions/food_functions.dart';

class FoodProvider with ChangeNotifier {
  final FoodFunctions apiServices = FoodFunctions();
  List<Food> displayedFoods = [];
  bool isLoading = true;

  FoodProvider() {
    loadInitialFoods();
  }

  Future<void> loadInitialFoods() async {
    isLoading = true;
    notifyListeners();

    displayedFoods = await apiServices.getFoodsByCategory("Atıştırmalık");

    isLoading = false;
    notifyListeners();
  }
}
