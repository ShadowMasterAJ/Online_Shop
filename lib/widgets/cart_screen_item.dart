import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreenItem extends StatefulWidget {
  final String id, title, imageURL;
  final double price;
  final int quantity;
  CartScreenItem(
      {this.id, this.price, this.quantity, this.title, this.imageURL});

  @override
  _CartScreenItemState createState() => _CartScreenItemState();
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

class _CartScreenItemState extends State<CartScreenItem> {
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
        color: Colors.grey[200],
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  widget.imageURL,
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                ),
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
                    height: 5,
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
