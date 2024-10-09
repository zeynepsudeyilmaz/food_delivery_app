import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/basket_iconbutton.dart';
import 'package:food_delivery_app/components/category_list.dart';
import 'package:food_delivery_app/components/search_bar.dart';
import 'package:food_delivery_app/functions/category_functions.dart';
import 'package:food_delivery_app/functions/favorites_functions.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/foods_model.dart';
import 'package:food_delivery_app/screens/menu_screen/food_detail.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../functions/food_functions.dart';
import '../../models/cart_item.dart';
import '../../models/category_model.dart';
import '../../utils/app_colors.dart';
import '../menu_screen/snacks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Food> displayedFoods = [];
  FoodFunctions apiServices = FoodFunctions();
  CategoryFunctions categoryFunctions = CategoryFunctions();
  Category? selectedCategory;
  List<Food> snacksList = [];

  Future<void> getSnacks() async {
    try {
      final List<Food> snacks =
          await apiServices.getFoodsByCategory("Atıştırmalıklar");
      setState(() {
        isLoading = false;
        snacksList = snacks;
      });
    } catch (e) {
      print('Error fetching snacks: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getSnacks();
    filterfoods(Category(name: "Atıştırmalık"));
  }

  void filterfoods(Category category) async {
    setState(() {
      isLoading = true;
    });

    var snacks = await apiServices.getFoodsByCategory(category.name);

    setState(() {
      displayedFoods = snacks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categories = CategoryFunctions.getCategories();
    final provider = FavoriteProvider.of(context);
    final cart = Provider.of<CartModel>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 16, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Merhaba, Hoş Geldiniz!",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  BasketIconbutton(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MySearchBar(),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                CategoryList(
                  categories: categories,
                  onCategorySelected: (Category selectedCategory) {
                    filterfoods(selectedCategory);
                    setState(() {
                      this.selectedCategory = selectedCategory;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (selectedCategory != null) {
                          categoryFunctions.gotoCategory(
                              context, selectedCategory!.name);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SnacksPage(
                                displayedFoods: [],
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Hepsini Gör",
                        style: AppTextStyles.d1,
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  CircularProgressIndicator()
                else if (displayedFoods.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            snacksList.length > 6 ? 6 : snacksList.length,
                        itemBuilder: (context, index) {
                          final snack = snacksList[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodDetailPage(
                                                food: snack,
                                                heroTag: 'snack_${snack.id}',
                                              )));
                                },
                                child: Hero(
                                  tag: 'snack_${snack.id}',
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(12)),
                                            child: Image.network(
                                              snack.image,
                                              fit: BoxFit.contain,
                                              width: 200,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snack.name,
                                                style: AppTextStyles
                                                    .headlineMedium,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '₺${snack.price.toStringAsFixed(2)}',
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
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  Container(
                                                    height: 50,
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
                                                        final cartItem =
                                                            CartItem(
                                                                food: snack,
                                                                quantity: 1);
                                                        cart.addItem(cartItem);
                                                      },
                                                      icon: Icon(
                                                        LineAwesomeIcons
                                                            .shopping_cart_solid,
                                                        size: 30,
                                                        color:
                                                            AppColors.primary,
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
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 1,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    provider.toggleFavorite(snack);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          provider.isExist(snack)
                                              ? 'Favorilere eklendi'
                                              : 'Favorilerden çıkarıldı',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    provider.isExist(snack)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: provider.isExist(snack)
                                        ? Colors.red
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: displayedFoods.length > 6
                            ? 6
                            : displayedFoods.length,
                        itemBuilder: (context, index) {
                          final snack = displayedFoods[index];
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FoodDetailPage(
                                                food: snack,
                                                heroTag: 'snack_${snack.id}',
                                              )));
                                },
                                child: Hero(
                                  tag: 'snack_${snack.id}',
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 4,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(12)),
                                            child: Image.network(
                                              snack.image,
                                              fit: BoxFit.contain,
                                              width: 200,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snack.name,
                                                style: AppTextStyles
                                                    .headlineMedium,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '₺${snack.price.toStringAsFixed(2)}',
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
                                                  const SizedBox(
                                                    width: 50,
                                                  ),
                                                  Container(
                                                    height: 50,
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
                                                        final cartItem =
                                                            CartItem(
                                                                food: snack,
                                                                quantity: 1);
                                                        cart.addItem(cartItem);
                                                      },
                                                      icon: Icon(
                                                        LineAwesomeIcons
                                                            .shopping_cart_solid,
                                                        size: 30,
                                                        color:
                                                            AppColors.primary,
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
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 1,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    provider.toggleFavorite(snack);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          provider.isExist(snack)
                                              ? 'Favorilere eklendi'
                                              : 'Favorilerden çıkarıldı',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    provider.isExist(snack)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: provider.isExist(snack)
                                        ? Colors.red
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
