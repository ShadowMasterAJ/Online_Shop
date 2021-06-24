import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id, title;
  final double price;
  final int quantity;
  CartItem({this.id, this.price, this.quantity, this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Chip(
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$$price',
                style: TextStyle(fontSize: 20),
              ),
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              'Total: \$${(price * quantity).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
          ),
          trailing: Text(
            '${quantity}x',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
