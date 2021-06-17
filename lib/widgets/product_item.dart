import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  String id, title, imageURL;
  ProductItem(this.id, this.imageURL, this.title);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart),
        ),
      ),
    );
  }
}
