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
//-----------------------------------------------------------------------------------------------
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
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.id);
      },
      child: Card(
        elevation: 5,
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
              // color: Colors.amber,
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
