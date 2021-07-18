import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

import '../screens/cart_screen.dart';

enum FilterOptions { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavorites = false;
  var _initState = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshProdData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndGetProducts();
  }

  @override
  void didChangeDependencies() {
    if (_initState) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndGetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _initState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.orange,
          Colors.deepOrange,
          Colors.deepOrange,
          Colors.orange,
        ],
      )),
      child: Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).primaryIconTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'ShopStop',
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
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                    selection == FilterOptions.Favorites
                        ? _showFavorites = true
                        : _showFavorites = false;
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
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w100)),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: Text('Show All',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w100)),
                    value: FilterOptions.All,
                  ),
                ],
              ),
            ],
          ),
          drawer: AppDrawer(),
          body: Container(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                      backgroundColor: Colors.black,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProdData(context),
                    backgroundColor: Colors.black,
                    color: Theme.of(context).accentColor,
                    child: SafeArea(child: ProductsGrid(_showFavorites))),
          )),
    );
  }
}
