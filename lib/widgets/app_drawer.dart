import 'package:fashion_eshop/models/custom_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';
import '../models/custom_route.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
      child: Drawer(
        child: Container(
          color: Colors.grey[900],
          child: Column(
            children: [
              AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: Colors.grey[800],
                title: Text(
                  'Hello Friend',
                  style: Theme.of(context).textTheme.headline5,
                ),
                automaticallyImplyLeading: false,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Shop',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacementNamed(OrdersScreen.routeName);
                  Navigator.of(context).pushReplacement(
                    CustomRoute(
                      builder: (context) => OrdersScreen(),
                    ),
                  );
                },
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Orders',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UserProductsScreen.routeName);
                },
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Manage Products',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                },
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Log Out',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontSize: 22)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
