import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // String id, title, imageURL;
  // ProductItem(this.id, this.imageURL, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            child: Image.network(
              product.imageURL,
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  iconSize: 20,
                  padding: EdgeInsets.all(1),
                  onPressed: product.toggleFavoriteStatus,
                  icon: Icon(
                    product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  product.title,
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
      ),
    );
  }
}
