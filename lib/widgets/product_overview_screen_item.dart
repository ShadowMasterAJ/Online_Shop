import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

class ProductItem extends StatefulWidget {
  // String id, title, imageURL;
  // ProductItem(this.id, this.imageURL, this.title);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height * .2,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: GridTile(
              child: Image.network(
                product.imageURL,
                fit: BoxFit.fill,
              ),
              footer: Container(
                child: GridTileBar(
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
                  title: Text(
                    product.title,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                  trailing: Consumer<Cart>(
                    builder: (_, cart, child) =>
                        cart.itemQuantity(product.id) > 0
                            ? Badge(
                                child: child,
                                value: cart.itemQuantity(product.id).toString(),
                                color: Theme.of(context).primaryIconTheme.color,
                              )
                            : child,
                    child: IconButton(
                      iconSize: 20,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        setState(() {
                          cart.addItem(
                            product.id,
                            product.title,
                            product.imageURL,
                            product.price,
                          );
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 3),
                              content:
                                  Text('Item was successfully added to cart'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.subtractQuantity(product.id);
                                },
                              ),
                            ),
                          );
                        });
                      },
                      icon: Icon(
                        cart.itemInCart(product.id)
                            ? Icons.shopping_cart
                            : Icons.shopping_cart_outlined,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 45,
          right: 45,
          bottom: 0,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              // boxShadow: [
              //   BoxShadow(offset: Offset(0, 10), blurRadius: 50),
              // ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).accentColor,
                // width: 2,
              ),
              color: Colors.black87,
            ),
            alignment: Alignment.center,
            child: Text(
              '\$${product.price}',
              style:
                  Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
            ),
          ),
        )
      ]),
    );
  }
}
