import 'package:flutter/material.dart';

import '../widgets/cart_item.dart';
import '../providers/cart.dart';
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;
  OrderItem({
    @required this.amount,
    @required this.id,
    @required this.products,
    @required this.date,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _order = [];
  List<OrderItem> get orders {
    return [..._order];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _order.insert(
      0,
      OrderItem(
        amount: total,
        id: DateTime.now().toString(),
        products: cartItems,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clearItems() {
    _items = [];
    notifyListeners();
  }
}
