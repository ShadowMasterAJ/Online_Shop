import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

import '../widgets/order_screen_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(Duration.zero).then((_) =>
  //       {Provider.of<Orders>(context, listen: false).fetchAndSetOrders()});
  // }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'My Orders',
            style: Theme.of(context).textTheme.headline5,
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
              tooltip: 'Add Item',
            )
          ],
        ),
        drawer: AppDrawer(),
        body: ordersData.orders.length <= 0
            ? Center(
                child: Text(
                  'No Orders Yet!',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black,
                      ),
                ),
              )
            : FutureBuilder(
                future: Provider.of<Orders>(context, listen: false)
                    .fetchAndSetOrders(),
                builder: (ctx, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (dataSnapshot.error != null) {
                      // ...
                      // Do error handling stuff
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    } else {
                      return Consumer<Orders>(
                        builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: ordersData.orders.length,
                          itemBuilder: (ctx, i) =>
                              OrderScreenItem(ordersData.orders[i]),
                        ),
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
