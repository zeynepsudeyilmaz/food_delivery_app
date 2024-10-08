import 'package:flutter/material.dart';
import '../functions/food_functions.dart';
import '../models/foods_model.dart';
import '../screens/search_result_screen/search_result.dart';
import '../utils/app_colors.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<Food> _allFoods = [];

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadFoods() async {
    try {
      FoodFunctions foodFunctions = FoodFunctions();
      List<Food> foods = await foodFunctions.getFoods();
      setState(() {
        _allFoods = foods;
      });
    } catch (e) {
      print('Veri yüklenirken bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResultsPage(
                      allFoods: _allFoods,
                      searchQuery: _controller.text,
                    )));
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.primary,
        ),
        hintText: 'Ara',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
