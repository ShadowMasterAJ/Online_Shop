import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepOrange, //change your color here
        ),
        title: Text(
          'Your Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(
                id: cart.items.values.toList()[i].id,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
              ),
            ),
          ),
          Card(
            elevation: 10,
            color: Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepOrange, width: 2),
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'ORDER NOW',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
