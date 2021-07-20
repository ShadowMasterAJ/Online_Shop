import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// import '../widgets/cart_item.dart';
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

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  String _authToken;
  Orders(this._authToken,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shopstop-21329-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$_authToken');

    final response = await http.get(url);
    final List<OrderItem> fetchedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //
    print('Orders: $extractedData');

    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      fetchedOrders.add(
        OrderItem(
          id: orderID,
          amount: double.parse(orderData['total']),
          date: DateTime.parse(orderData['date']),
          products: (orderData['items'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
      _orders = fetchedOrders;
    });
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url = Uri.parse(
        'https://shopstop-21329-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json?auth=$_authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'total': total.toStringAsFixed(2),
        'date': timeStamp.toIso8601String(),
        'items': cartItems
            .map((cartProduct) => {
                  'id': cartProduct.id,
                  'title': cartProduct.title,
                  'price': cartProduct.price,
                  'quantity': cartProduct.quantity,
                })
            .toList(),
      }),
    );
    final newOrder = OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      products: cartItems,
      date: timeStamp,
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}
