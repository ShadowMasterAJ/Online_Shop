import 'package:flutter/foundation.dart';

class CartItem {
  final String id, title, imageURL;
  int quantity;
  final double price;

  CartItem({
    this.id,
    this.price,
    this.quantity,
    this.title,
    this.imageURL,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  bool itemInCart(String productId) {
    return _items.containsKey(productId);
  }

  int itemQuantity(String productID) {
    return _items[productID] != null ? _items[productID].quantity : 0;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((id, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productID, title, imageURL, double price) {
    if (_items.containsKey(productID)) {
      _items.update(
        productID,
        (currentProd) => CartItem(
            id: productID,
            title: title,
            price: price,
            imageURL: imageURL,
            quantity: currentProd.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productID,
          () => CartItem(
              id: productID,
              title: title,
              price: price,
              imageURL: imageURL,
              quantity: 1));
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void subtractQuantity(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              price: existingItem.price,
              title: existingItem.title,
              imageURL: existingItem.imageURL,
              quantity: existingItem.quantity - 1));
    } else {
      removeItem(productId);
    }
    notifyListeners();
  }

  void addQuantity(String productId) {
    _items.update(
        productId,
        (existingItem) => CartItem(
            id: existingItem.id,
            price: existingItem.price,
            title: existingItem.title,
            imageURL: existingItem.imageURL,
            quantity: existingItem.quantity + 1));
    notifyListeners();
  }

  void clearItems() {
    _items = {};
    notifyListeners();
  }
}
