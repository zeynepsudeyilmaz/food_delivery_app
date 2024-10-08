import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/cart_drawer.dart';
import 'package:provider/provider.dart';
import '../functions/drawer_functions.dart';
import '../utils/app_colors.dart';
import '../models/cart_model.dart';

class BasketIconbutton extends StatelessWidget {
  const BasketIconbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.color1,
        ),
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                showDrawer(context, const CartDrawer());
              },
              icon: const Icon(Icons.shopping_basket, size: 24),
              color: AppColors.primary,
            ),
            if (cart.totalItems > 0)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Text(cart.totalItems.toString(),
                      style: TextStyle(fontSize: 14)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
