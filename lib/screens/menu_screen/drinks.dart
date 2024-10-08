import 'package:flutter/material.dart';
import 'package:food_delivery_app/functions/food_functions.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/filter_component.dart';
import '../../components/search_bar.dart';
import '../../functions/favorites_functions.dart';
import '../../functions/filter_functions.dart';
import '../../models/cart_item.dart';
import '../../models/cart_model.dart';
import '../../models/foods_model.dart';
import '../../utils/app_colors.dart';
import 'food_detail.dart';

class DrinksPage extends StatefulWidget {
  final List<Food> displayedFoods;

  const DrinksPage({Key? key, required this.displayedFoods}) : super(key: key);

  @override
  State<DrinksPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<DrinksPage> {
  bool isLoading = true;
  FoodFunctions apiServices = FoodFunctions();
  List<Food> drinksList = [];

  Future<void> getDrinks() async {
    try {
      final List<Food> drinks =
          await apiServices.getFoodsByCategory("İçecekler");
      setState(() {
        isLoading = false;
        drinksList = drinks;
      });
    } catch (e) {
      print('Error fetching drinks: $e');
    }
  }

  @override
  void initState() {
    getDrinks();
    super.initState();
  }

  void _onSortChanged(String sortType) {
    setState(() {
      drinksList = sortFoods(drinksList, sortType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final cart = Provider.of<CartModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("İÇECEKLER", style: AppTextStyles.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: MySearchBar(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilterComponent(onSortChanged: _onSortChanged),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: drinksList.length,
                      itemBuilder: (context, index) {
                        final drink = drinksList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodDetailPage(
                                  food: drink,
                                  heroTag: 'food_${drink.id}',
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: 'food_${drink.id}',
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                          child: Image.network(
                                            drink.image,
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
                                              child: Text(drink.name,
                                                  style: AppTextStyles
                                                      .headlineMedium),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '₺${drink.price.toStringAsFixed(2)}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall
                                                      ?.copyWith(
                                                        color:
                                                            AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppColors.bgColor,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      final cartItem = CartItem(
                                                          food: drink,
                                                          quantity: 1);
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
                                        provider.toggleFavorite(drink);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              provider.isExist(drink)
                                                  ? 'Favorilere eklendi'
                                                  : 'Favorilerden çıkarıldı',
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        provider.isExist(drink)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: provider.isExist(drink)
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
          ],
        ),
      ),
    );
  }
}
