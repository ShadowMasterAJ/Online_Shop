import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatefulWidget {
  final String id, title;
  final double price;
  final int quantity;
  CartItem({this.id, this.price, this.quantity, this.title});

  @override
  _CartItemState createState() => _CartItemState();
}

Widget _showDeletionAlertBox(context) {
  return AlertDialog(
    title: Text(
      'Are you sure?',
      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24),
    ),
    content: Text(
      'Do you want to remove this item from the cart?',
      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 20),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(false);
        },
        child: Text(
          'No',
          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: Text(
          'Yes',
          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 18),
        ),
      ),
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Colors.grey[800],
    elevation: 10,
  );
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: BorderRadius.circular(20)),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context, builder: (ctx) => _showDeletionAlertBox(context));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.id);
      },
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black),
              ),
              child: Chip(
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '\$${widget.price}',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    'Total: \$${(widget.price * widget.quantity).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<Cart>(context, listen: false)
                              .addQuantity(widget.id);
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text('${widget.quantity}x',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<Cart>(context, listen: false)
                              .subtractQuantity(widget.id);
                          if (widget.quantity <= 0) {
                            print('Showing snacks');
                            Provider.of<Cart>(context, listen: false)
                                .removeItem(widget.id);
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
