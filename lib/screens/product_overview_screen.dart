import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart.dart';

import '../screens/cart_screen.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).primaryIconTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'My Shop',
            style: Theme.of(context).textTheme.headline6,
          ),
          backgroundColor: Colors.grey[900],
          actions: [
            Consumer<Cart>(
              builder: (_, cart, child) => cart.itemCount > 0
                  ? Badge(
                      child: child,
                      value: cart.itemCount.toString(),
                    )
                  : child,
              child: IconButton(
                icon: Icon(
                  cart.itemCount > 0
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            PopupMenuButton<Object>(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (Object selection) {
                setState(() {
                  if (selection == FilterOptions.Favorites) {
                    _showFavorites = true;
                  } else {
                    _showFavorites = false;
                  }
                });
              },
              icon: Icon(
                Icons.more_vert_rounded,
                size: 30,
                color: Theme.of(context).accentColor,
              ),
              itemBuilder: (ctx) => <PopupMenuEntry<Object>>[
                PopupMenuItem(
                  child: Text('Show Favourites',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w100)),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuDivider(
                    // height: 20,
                    ),
                PopupMenuItem(
                  child: Text('Show All',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w100)),
                  value: FilterOptions.All,
                ),
              ],
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: ProductsGrid(_showFavorites));
  }
}
