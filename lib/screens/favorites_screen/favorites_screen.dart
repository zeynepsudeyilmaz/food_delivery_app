import 'package:flutter/material.dart';
import '../../functions/favorites_functions.dart';
import '../menu_screen/food_detail.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    final provider = FavoriteProvider.of(context, listen: false);
    provider.fetchFavoritesFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorilerim"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: finalList.isEmpty
            ? Center(
                child: Text(
                  'Favori yiyecek yok!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.90,
                  ),
                  itemCount: finalList.length,
                  itemBuilder: (context, index) {
                    final favorite = finalList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                              food: favorite,
                              heroTag: 'favorite_${favorite.id}',
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Hero(
                                  tag: 'favorite_${favorite.id}',
                                  child: Card(
                                    elevation: 3,
                                    child: Image.network(
                                      favorite.image,
                                      width: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Center(
                                  child: Text(
                                    favorite.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 1,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                provider.toggleFavorite(favorite);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      provider.isExist(favorite)
                                          ? 'Favorilere eklendi'
                                          : 'Favorilerden çıkarıldı',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                provider.isExist(favorite)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: provider.isExist(favorite)
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
