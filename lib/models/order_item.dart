import 'foods_model.dart';

class OrderItem {
  final Food food;
  final int quantity;

  OrderItem({
    required this.food,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'foodId': food.id,
      'quantity': quantity,
      'name': food.name,
      'price': food.price,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      food: Food(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        category: json['category'],
        image: json['image'],
      ),
      quantity: json['quantity'],
    );
  }
}
