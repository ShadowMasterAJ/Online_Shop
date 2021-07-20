import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id, title, description, imageURL;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageURL,
    @required this.price,
    this.isFavorite = false,
  });
  Future<void> toggleFavoriteStatus(String _authToken) async {
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://shopstop-21329-default-rtdb.asia-southeast1.firebasedatabase.app/products/$id.json?auth=$_authToken');
    await http.patch(url,
        body: json.encode({
          'isFavorite': isFavorite
        }));
    notifyListeners();
  }
}
