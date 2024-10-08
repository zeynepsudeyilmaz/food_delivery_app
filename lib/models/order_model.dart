import 'package:food_delivery_app/models/order_item.dart';

class Orders {
  final List<OrderItem> items;
  final double totalPrice;
  final DateTime orderDate;

  Orders({
    required this.items,
    required this.totalPrice,
    required this.orderDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
    };
  }

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      orderDate: DateTime.parse(json['orderDate']),
    );
  }
}
