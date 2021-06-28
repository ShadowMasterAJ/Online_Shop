import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_products_screen_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'You Products',
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) => Column(
                      children: [
                        UserProductScreenItem(
                          imageURL: productsData.items[i].imageURL,
                          title: productsData.items[i].title,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: Divider(
                            color: Colors.black,
                          ),
                        )
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
