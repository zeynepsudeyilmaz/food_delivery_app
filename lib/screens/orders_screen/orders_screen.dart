import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_text_styles.dart';
import '../../services/order_services/order_services.dart';

class OrdersScreen extends StatefulWidget {
  final bool isFromNavbar;

  const OrdersScreen({super.key, required this.isFromNavbar});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderService _orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFromNavbar
          ? AppBar(
              title: const Text("Siparişlerim"),
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
            )
          : AppBar(
              title: const Text("Siparişlerim"),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _orderService.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Bir hata oluştu."));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final orderList = snapshot.data!;
                return ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    final orderData = orderList[index];
                    final totalPrice = orderData['totalPrice'];
                    final orderDate = DateTime.parse(orderData['orderDate']);
                    final items = orderData['items'] as List<dynamic>;

                    String formattedDate =
                        "${orderDate.day}/${orderDate.month}/${orderDate.year}";

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ExpansionTile(
                        title: Text(
                          "Sipariş Tarihi: $formattedDate",
                          style: AppTextStyles.displaySmall,
                        ),
                        subtitle: Text(
                          "Toplam Fiyat: ₺${totalPrice.toStringAsFixed(0)}",
                          style: AppTextStyles.displaySmall,
                        ),
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, itemIndex) {
                              final item = items[itemIndex];
                              return ListTile(
                                title: Text(item['name'],
                                    style: AppTextStyles.displaySmall),
                                subtitle: Text(
                                    "Fiyat: ₺${item['price']}\nMiktar: ${item['quantity']}",
                                    style: AppTextStyles.displaySmall),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "Henüz siparişiniz yok.",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
