import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/edit_user_product_state_screen.dart';
import '../providers/products.dart';

class UserProductScreenItem extends StatelessWidget {
  Widget _showDeletionAlertBox(context) {
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
          onPressed: () {
            Provider.of<Products>(context, listen: false).deleteProduct(id);
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

  final String id, title, imageURL;
  UserProductScreenItem({this.id, this.imageURL, this.title});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // minRadius: 40,
        radius: 30,
        backgroundImage: NetworkImage(imageURL),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 22),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, EdiUserProductsStateScreen.routeName,
                      arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                )),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => _showDeletionAlertBox(context));
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
