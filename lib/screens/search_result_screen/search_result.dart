import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/menu_screen/food_detail.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../functions/favorites_functions.dart';
import '../../models/cart_item.dart';
import '../../models/cart_model.dart';
import '../../models/foods_model.dart';
import '../../utils/app_colors.dart';

class SearchResultsPage extends StatefulWidget {
  final List<Food> allFoods;
  final String searchQuery;

  const SearchResultsPage({
    super.key,
    required this.allFoods,
    required this.searchQuery,
  });

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<Food> _filteredFoods = [];

  @override
  void initState() {
    super.initState();
    _filterFoods(widget.searchQuery);
  }

  void _filterFoods(String query) {
    final filteredFoods = widget.allFoods.where((food) {
      return food.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredFoods = filteredFoods;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final cart = Provider.of<CartModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onChanged: _filterFoods,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.primary,
            ),
            hintText: 'Ara...',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: _filteredFoods.isEmpty
          ? Center(
              child: Text(
                'Sonuç bulunamadı.',
                style: TextStyle(color: AppColors.primary, fontSize: 16),
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(10),
                itemCount: _filteredFoods.length,
                itemBuilder: (context, index) {
                  final food = _filteredFoods[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailPage(
                            food: food,
                            heroTag: 'food_${food.id}',
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'food_${food.id}',
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      food.image,
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(food.name,
                                            style:
                                                AppTextStyles.headlineMedium),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₺${food.price.toStringAsFixed(2)}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: AppColors.bgColor,
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                final cartItem = CartItem(
                                                    food: food, quantity: 1);
                                                cart.addItem(cartItem);
                                              },
                                              icon: Icon(
                                                LineAwesomeIcons
                                                    .shopping_cart_solid,
                                                size: 35,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 1,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  provider.toggleFavorite(food);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        provider.isExist(food)
                                            ? 'Favorilere eklendi'
                                            : 'Favorilerden çıkarıldı',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  provider.isExist(food)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: provider.isExist(food)
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
