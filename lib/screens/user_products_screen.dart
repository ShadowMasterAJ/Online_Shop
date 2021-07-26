import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_products_screen_item.dart';

import '../screens/edit_user_product_state_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProdData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndGetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              'Your Products',
              style: Theme.of(context).textTheme.headline6,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.grey[900],
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                icon: Icon(
                  Icons.home_filled,
                  color: Theme.of(context).accentColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditUserProductsStateScreen.routeName);
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          drawer: AppDrawer(),
          body: FutureBuilder(
            future: _refreshProdData(context),
            builder: (ctx, snapShot) => snapShot.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    backgroundColor: Colors.black,
                    color: Theme.of(context).accentColor,
                    onRefresh: () => _refreshProdData(context),
                    child: Consumer<Products>(
                      builder: (ctx, productsData, _) => productsData
                                  .items.length >
                              0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: productsData.items.length,
                                    itemBuilder: (_, i) => Column(
                                      children: [
                                        UserProductScreenItem(
                                          id: productsData.items[i].id,
                                          price: productsData.items[i].price,
                                          description:
                                              productsData.items[i].description,
                                          imageURL:
                                              productsData.items[i].imageURL,
                                          title: productsData.items[i].title,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'You currently do not have any products!',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Click the + button to add some',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
          )),
    );
  }
}
