import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'product_overview_screen_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavs;
  ProductsGrid(this._showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = _showFavs ? productsData.favItems : productsData.items;
    return products.length > 0
        ? GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 1500 / 1600,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: ProductItem(),
            ),
          )
        : !_showFavs
            ? Center(
                child: Text('No Items Yet!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
              )
            : Center(
                child: Text('No Favorite Items Yet!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4),
              );
  }
}
