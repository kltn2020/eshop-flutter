import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce_flutter/src/models/Cart.dart';
import 'package:ecommerce_flutter/src/views/order_history.dart';
import 'package:ecommerce_flutter/src/widgets/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:ecommerce_flutter/src/models/Product.dart';
import 'package:ecommerce_flutter/src/redux/products/products_actions.dart';
import 'package:ecommerce_flutter/src/redux/store.dart';

class User extends StatefulWidget {
  User({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  //Search
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: AutoSizeText(
          Redux.store.state.userState.user.email,
          style: TextStyle(
            color: Color.fromRGBO(79, 59, 120, 1),
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: StoreConnector<AppState, Cart>(
              distinct: true,
              converter: (store) => store.state.cartState.cart,
              builder: (context, cart) {
                return Stack(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      size: 32,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          cart.products
                              .fold(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + element.quantity)
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            color: Color.fromRGBO(146, 127, 191, 1),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Order",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/order-history');
                  },
                  child: Text(
                    "View order history",
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            /* Order Status line */
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistory(
                                status: 'processing',
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment,
                            size: 32,
                            color: Colors.amber[600],
                          ),
                          Text(
                            "Processing",
                            style: TextStyle(
                              color: Colors.amber[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistory(
                                status: 'shipping',
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.airport_shuttle,
                            size: 32,
                            color: Colors.blue,
                          ),
                          Text(
                            "Shipping",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistory(
                                status: 'completed',
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.check,
                            size: 32,
                            color: Colors.green,
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistory(
                                status: 'cancelled',
                              ),
                            ));
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.cancel,
                            size: 32,
                            color: Colors.redAccent,
                          ),
                          Text(
                            "Cancelled",
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.label_outline,
                      color: Colors.orangeAccent,
                    ),
                    title: Text("Voucher List"),
                    onTap: () => {
                      Navigator.pushNamed(context, '/voucher-list'),
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.favorite_border,
                      color: Colors.redAccent,
                    ),
                    title: Text("Favorite List"),
                    onTap: () => {
                      Navigator.pushNamed(context, '/favorite-list'),
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                    ),
                    title: Text("Account Setting"),
                    onTap: () => {
                      Navigator.pushNamed(context, '/account-setting'),
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help,
                      color: Colors.blueAccent,
                    ),
                    title: Text("Help Center"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationWidget(context, 2),
    );
  }
}
