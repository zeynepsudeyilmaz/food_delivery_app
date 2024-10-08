import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/models/cart_item.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../models/foods_model.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;
  final String heroTag;

  const FoodDetailPage({
    super.key,
    required this.food,
    required this.heroTag,
  });

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.food.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Hero(
              tag: widget.heroTag,
              child: Image.network(
                widget.food.image,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fiyat: ${(widget.food.price * quantity)} ₺',
                  style: AppTextStyles.displaySmall,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        LineAwesomeIcons.minus_circle_solid,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(
                      '$quantity',
                      style: AppTextStyles.displaySmall,
                    ),
                    IconButton(
                      icon: const Icon(
                        LineAwesomeIcons.plus_circle_solid,
                        color: AppColors.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: AppColors.primary,
              thickness: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.food.description!,
              style: AppTextStyles.displaySmall,
            ),
            const SizedBox(
              height: 40,
            ),
            Button(
              padding: EdgeInsets.symmetric(horizontal: 30),
              onPressed: () {
                final cart = Provider.of<CartModel>(context, listen: false);
                final cartItem =
                    CartItem(food: widget.food, quantity: quantity);
                cart.addItem(cartItem);
              },
              title: "Sepete Ekle",
              icon: LineAwesomeIcons.cart_plus_solid,
            ),
          ],
        ),
      ),
    );
  }
}
