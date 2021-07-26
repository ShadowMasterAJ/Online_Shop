import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_user_product_state_screen.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';

class UserProductScreenItem extends StatefulWidget {
  final String id, title, description, imageURL;
  final double price;
  UserProductScreenItem({
    this.description,
    this.price,
    this.id,
    this.imageURL,
    this.title,
  });

  @override
  _UserProductScreenItemState createState() => _UserProductScreenItemState();
}

class _UserProductScreenItemState extends State<UserProductScreenItem> {
  bool _showDescription = false;

  Widget _showDeletionAlertBox(context) {
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    var theme = Theme.of(context);
    return AlertDialog(
      title: Text(
        'Are you sure?',
        style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 24),
      ),
      content: Text(
        'Do you want to remove this item?\nThis action cannot be undone',
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
          onPressed: () async {
            try {
              Navigator.of(context).pop(true);

              await Provider.of<Products>(context, listen: false)
                  .deleteProduct(widget.id);
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Text(
                    "Item Deleted Successfully!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 20),
                  ),
                ),
              );
            } catch (error) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Text(
                    "Deletion failed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.errorColor, fontSize: 20),
                  ),
                ),
              );
            }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: widget.id,
        );
      },
      child: Card(
        elevation: 15,
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(widget.imageURL),
                ),
                title: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  '\$${widget.price.toStringAsFixed(2)}',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: 18),
                ),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _showDescription = !_showDescription;
                            });
                          },
                          tooltip: 'Item Description',
                          icon: Icon(
                            Icons.info,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditUserProductsStateScreen.routeName,
                                  arguments: widget.id);
                            },
                            tooltip: 'Edit Item',
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).accentColor,
                            )),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) =>
                                    _showDeletionAlertBox(context));
                          },
                          tooltip: 'Delete Item',
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (_showDescription)
                Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 15),
                  child: Text(
                    widget.description,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 20),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
