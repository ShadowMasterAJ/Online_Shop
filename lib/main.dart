import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_user_product_state_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
            primarySwatch: Colors.grey,
            accentColor: Colors.deepOrange,
            primaryIconTheme: IconThemeData(color: Colors.amber),
            canvasColor: Colors.grey.withAlpha(165),
            dividerTheme: DividerThemeData(color: Colors.red, thickness: 1.5),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[900],
                titleTextStyle: Theme.of(context).textTheme.headline6),
            textTheme: TextTheme(
              headline6: TextStyle(color: Colors.deepOrange, fontSize: 24),
              headline5: TextStyle(color: Colors.white),
              headline4:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            fontFamily: 'Lato'),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EdiUserProductsStateScreen.routeName: (ctx) =>
              EdiUserProductsStateScreen(),
        },
      ),
    );
  }
}
