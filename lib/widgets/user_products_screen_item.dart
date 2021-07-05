import 'package:flutter/material.dart';
import '../screens/edit_user_product_state_screen.dart';

class UserProductScreenItem extends StatelessWidget {
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
                      context, EdiUserProductsStateScreen.routeName,arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black,
                )),
            IconButton(
              onPressed: () {},
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
