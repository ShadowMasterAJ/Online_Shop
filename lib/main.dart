import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_user_product_state_screen.dart';
import './screens/auth_screen.dart';

import './providers/auth.dart';
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
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products('', []),
          update: (ctx, auth, prevProducts) => Products(
              auth.token, prevProducts == null ? [] : prevProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', []),
          update: (ctx, auth, prevOrders) =>
              Orders(auth.token, prevOrders == null ? {} : prevOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
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
          home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EdiUserProductsStateScreen.routeName: (ctx) =>
                EdiUserProductsStateScreen(),
          },
        ),
      ),
    );
  }
}
