import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/order_item.dart';
import 'package:food_delivery_app/models/order_model.dart';
import '../services/order_services/order_services.dart';
import 'cart_item.dart';

class CartModel with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Toplam fiyat hesaplama
  double get totalPrice {
    return _items.fold(
        0, (total, item) => total + (item.food.price * item.quantity));
  }

  // Sepete ürün ekleme
  void addItem(CartItem cartItem) {
    final index = _items.indexWhere((item) => item.food.id == cartItem.food.id);
    if (index != -1) {
      _items[index].quantity += cartItem.quantity;
    } else {
      _items.add(cartItem);
    }
    notifyListeners();
  }

  // Sipariş oluşturma
  Future<void> placeOrder(OrderService orderService,
      {required String selectedAddressId,
      required String selectedCardId}) async {
    if (_items.isEmpty) return;

    // Siparişi oluştur
    Orders newOrder = Orders(
      items: _items
          .map((item) => OrderItem(food: item.food, quantity: item.quantity))
          .toList(),
      totalPrice: totalPrice,
      orderDate: DateTime.now(),
    );

    // Siparişi Firestore'a ekle
    await orderService.addOrder(newOrder);
  }

  // Sepeti temizleme
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Ürün miktarını artırma
  void increaseQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Ürün miktarını azaltma
  void decreaseQuantity(String foodId) {
    final index = _items.indexWhere((item) => item.food.id == foodId);
    if (index != -1 && _items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    }
  }

  // Ürünü sepetten çıkarma
  void removeItem(String foodId) {
    _items.removeWhere((item) => item.food.id == foodId);
    notifyListeners();
  }

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }
}
