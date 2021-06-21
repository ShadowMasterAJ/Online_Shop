import 'dart:ffi';

import 'package:fashion_eshop/widgets/products_grid.dart';
import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          backgroundColor: Theme.of(context).primaryColorDark,
          actions: [
            PopupMenuButton(
              onSelected: (FilterOptions selection) {
                setState(() {
                  if (selection == FilterOptions.Favorites) {
                    _showFavorites = true;
                  } else {
                    _showFavorites = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert_rounded),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Show Favourites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                )
              ],
            )
          ],
        ),
        body: ProductsGrid(_showFavorites));
  }
}
