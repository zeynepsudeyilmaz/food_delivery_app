import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../models/category_model.dart';
import '../screens/menu_screen/desserts.dart';
import '../screens/menu_screen/drinks.dart';
import '../screens/menu_screen/foods.dart';
import '../screens/menu_screen/snacks.dart';

class CategoryFunctions {
  static List<Category> getCategories() {
    return [
      Category(
          name: 'Atıştırmalıklar', icon: LineAwesomeIcons.candy_cane_solid),
      Category(name: 'Yemek', icon: LineAwesomeIcons.hamburger_solid),
      Category(name: 'Tatlılar', icon: LineAwesomeIcons.cookie_solid),
      Category(name: 'İçecekler', icon: LineAwesomeIcons.cocktail_solid),
    ];
  }

  void gotoCategory(BuildContext context, String label) {
    if (label == "Atıştırmalıklar") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SnacksPage(
                    displayedFoods: [],
                  )));
    } else if (label == "Yemek") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoodsPage(
                    displayedFoods: [],
                  )));
    } else if (label == "Tatlılar") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DessertsPage(
                    displayedFoods: [],
                  )));
    } else if (label == "İçecekler") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DrinksPage(
                    displayedFoods: [],
                  )));
    }
  }
}
