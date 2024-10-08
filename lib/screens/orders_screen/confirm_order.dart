import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/button.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/screens/orders_screen/complete_order.dart';
import 'package:food_delivery_app/services/payment_services/card_services.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import 'package:provider/provider.dart';

import '../../models/cart_model.dart';
import '../../models/order_item.dart';
import '../../services/address_services/address_services.dart';
import '../../services/order_services/order_services.dart';
import '../../utils/app_colors.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  String? selectedAddressId;
  final AddressServices _addressServices = AddressServices();
  String? selectedCardId;
  final CardService _cardService = CardService();
  final OrderService _orderServices = OrderService();

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Siparişi Onayla"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Teslimat Adresi",
                style: AppTextStyles.headlineLarge,
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<Map<String, dynamic>>>(
                stream: _addressServices.getAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Hata oluştu!'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Kayıtlı adres bulunamadı.'));
                  }

                  final addresses = snapshot.data!;

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: AppColors.bgColor,
                      labelText: 'Adres Seçin',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    value: selectedAddressId,
                    items: addresses.map((address) {
                      return DropdownMenuItem<String>(
                        value: address['id'],
                        child: Text(address['addressName']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedAddressId = newValue;
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 0.5,
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Ödeme Yöntemi",
                style: AppTextStyles.headlineLarge,
              ),
              const SizedBox(height: 16),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _cardService.getCards(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Hata oluştu!'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Kayıtlı kart bulunamadı.'));
                  }

                  final cards = snapshot.data!;

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: AppColors.bgColor,
                      labelText: 'Kart Seçin',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    value: selectedCardId,
                    items: cards.map((card) {
                      return DropdownMenuItem<String>(
                        value: card['id'],
                        child: Text(
                            '${card['cardName']} - **** **** **** ${card['cardNumber'].substring(card['cardNumber'].length - 4)}'),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCardId = newValue;
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 0.5,
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Teslimat Süresi",
                style: AppTextStyles.headlineLarge,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Standart Teslimat",
                    style: AppTextStyles.displaySmall,
                  ),
                  Text(
                    "35-45 dakika",
                    style: AppTextStyles.displaySmall,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 0.5,
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                onPressed: () async {
                  if (selectedAddressId != null && selectedCardId != null) {
                    List<OrderItem> orderItems =
                        cartModel.items.map((cartItem) {
                      return OrderItem(
                        food: cartItem.food,
                        quantity: cartItem.quantity,
                      );
                    }).toList();

                    Orders order = Orders(
                      items: orderItems,
                      totalPrice: cartModel.totalPrice,
                      orderDate: DateTime.now(),
                    );

                    await _orderServices.addOrder(order);

                    cartModel.clearCart();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompleteOrder(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Lütfen bir adres ve ödeme yöntemi seçin.')),
                    );
                  }
                },
                title: "Sipariş Ver",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
