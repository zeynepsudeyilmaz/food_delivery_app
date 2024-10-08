import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/components/divider.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/screens/orders_screen/confirm_order.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class CartDrawer extends StatelessWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "SEPETİM",
                    style: AppTextStyles.headline,
                  ),
                ),
                const MyDivider(
                  color: AppColors.textWhite,
                  thickness: 0.5,
                ),
                if (cart.items.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "Sepetinizde ürün bulunmamaktadır",
                        style: AppTextStyles.headline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  ...cart.items.map((cartItem) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            cartItem.food.name,
                            style: AppTextStyles.bodyMedium,
                          ),
                          subtitle: Text(
                            'Fiyat: ${(cartItem.food.price * cartItem.quantity).toStringAsFixed(0)}',
                            style: AppTextStyles.bodyMedium,
                          ),
                          leading: ClipRRect(
                            child: Image.network(
                              cartItem.food.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  LineAwesomeIcons.minus_circle_solid,
                                  color: AppColors.textWhite,
                                  size: 20,
                                ),
                                onPressed: () {
                                  cart.decreaseQuantity(cartItem.food.id);
                                },
                              ),
                              Text(
                                '${cartItem.quantity}',
                                style: AppTextStyles.bodyMedium,
                              ),
                              IconButton(
                                icon: const Icon(
                                  LineAwesomeIcons.plus_circle_solid,
                                  color: AppColors.textWhite,
                                  size: 20,
                                ),
                                onPressed: () {
                                  cart.increaseQuantity(cartItem.food.id);
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  cart.removeItem(cartItem.food.id);
                                },
                                icon: Icon(
                                  LineAwesomeIcons.trash_solid,
                                  color: AppColors.textWhite,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const MyDivider(
                          color: AppColors.textWhite,
                          thickness: 0.5,
                        ),
                      ],
                    );
                  }).toList(),
                const SizedBox(height: 20),
                if (cart.items.isNotEmpty) ...[
                  Text('Toplam Fiyat: ${cart.totalPrice} ₺'),
                  const SizedBox(height: 20),
                  Button(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: AppColors.bgColor,
                            title: Text(
                              "Sepeti Temizle",
                              style: AppTextStyles.headlineMedium,
                            ),
                            content: Text(
                              "Sepeti temizlemek istediğinizden emin misiniz?",
                              style: AppTextStyles.displaySmall,
                            ),
                            actions: [
                              Button(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                title: "İptal",
                              ),
                              Button(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                onPressed: () {
                                  cart.clearCart();
                                  Navigator.of(context).pop();
                                },
                                title: "Evet",
                              ),
                            ],
                          );
                        },
                      );
                    },
                    title: "Sepeti Temizle",
                    backgroundColor: AppColors.scaffoldBackground,
                    foregroundColor: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmOrder()));
                    },
                    title: "Ödemeye Geç",
                    backgroundColor: AppColors.scaffoldBackground,
                    foregroundColor: AppColors.primary,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
