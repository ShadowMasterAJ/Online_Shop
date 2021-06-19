import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String id, title, imageURL;
  ProductItem(this.id, this.imageURL, this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          child: Image.network(
            imageURL,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              iconSize: 20,
              padding: EdgeInsets.all(1),
              onPressed: () {},
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).accentColor,
              ),
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            trailing: IconButton(
              iconSize: 20,
              padding: EdgeInsets.all(0),
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
