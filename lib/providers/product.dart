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
  Future<void> toggleFavoriteStatus(String authToken, String userID) async {
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://shopstop-21329-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userID/$id.json?auth=$authToken');
    await http.put(url, body: json.encode(isFavorite));
    notifyListeners();
  }
}
