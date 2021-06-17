import 'package:flutter/foundation.dart';

class Product {
  final String id, title, description, imageURL;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageURL,
    @required this.price,
    this.isFavorite,
  });
}
