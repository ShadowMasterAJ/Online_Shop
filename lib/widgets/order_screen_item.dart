import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderScreenItem extends StatefulWidget {
  final OrderItem order;
  OrderScreenItem(this.order);

  @override
  _OrderScreenItemState createState() => _OrderScreenItemState();
}

class _OrderScreenItemState extends State<OrderScreenItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      curve: Curves.linearToEaseOut,
      height:
          _expanded ? min(widget.order.products.length * 20.0 + 130, 200) : 100,
      child: Card(
        elevation: 15,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${widget.order.amount.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontSize: 20),
                          ),
                          Text(
                            DateFormat('dd MMM, yyyy hh:mm')
                                .format(widget.order.date),
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      icon: Icon(
                        _expanded
                            ? Icons.expand_less_sharp
                            : Icons.expand_more_sharp,
                        size: 30,
                      ),
                    )
                  ],
                ),
                if (_expanded)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 750),
                    curve: Curves.linearToEaseOut,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
                if (_expanded)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 750),
                    curve: Curves.linearToEaseOut,
                    height: _expanded
                        ? min(widget.order.products.length * 20.0 + 5, 200)
                        : 0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.order.products.length,
                      itemBuilder: (ctx, i) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.order.products[i].title.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w100)),
                          Text(
                              '${widget.order.products[i].quantity}x ${widget.order.products[i].price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                  ),
                if (_expanded)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 950),
                    curve: Curves.ease,
                    child: Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// if (_expanded)
//   Container(
//     alignment: Alignment.centerRight,
//     child: SizedBox(
//       height: 60,
//       width: 70,
//       child: Column(children: [
//         Divider(
//           color: Colors.black,
//         ),
//         Text('${widget.order.amount.toStringAsFixed(2)}',
//             style: Theme.of(context).textTheme.headline4.copyWith(
//                 fontSize: 18, fontWeight: FontWeight.w100)),
//       ]),
//     ),
//   ),
